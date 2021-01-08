include CommentsHelper

class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :submission

    validates :content, presence: true
    validates :level, presence: true

    def self.create_child_comment(content, parent_comment_id, user)
        self.transaction do
            parent_comment = self.find(parent_comment_id)
            child_comment = self.new(content: content)
            child_comment.parent_comment_id = parent_comment.id
            child_comment.user = user
            child_comment.submission = parent_comment.submission
            sibling_count = self.where(parent_comment_id: parent_comment_id).count
            child_comment.level = generate_comment_level(parent_comment.level, sibling_count)
            if child_comment.save
                parent_comment.upvotes += 1
            end
        end
    end

    def self.threads(user)
        submissions = self.select("submission_id").where(user: user).distinct.map {|comment| comment.submission_id}
        threads = Array.new
        submissions.each do |submission|
            comments = Comment.where(user: user, submission_id: submission).order(created_at: :desc)
            threads.push(valid_threads(comments))
        end
        return threads.flatten.sort_by {|thread| thread.created_at}
    end

    def self.valid_threads(comments)
        valid_threads = Array.new(comments.length, true)
        threads = Array.new
        comments.each_with_index do |comment_to_compare, index|
            comments.each_with_index do |comment, idx|
                if index != idx and valid_threads[idx]
                valid_threads[idx] = !comment.level.start_with?(comment_to_compare.level)
                end
            end 
        end

        valid_threads.each_with_index do |valid_thread, index|
            threads.push(comments[index]) if valid_thread
        end

        return threads
    end
end
