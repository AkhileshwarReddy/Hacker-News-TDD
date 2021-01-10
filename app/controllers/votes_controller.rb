class VotesController < ApplicationController
    before_action :authenticate_user!, only: [:vote, :upvoted]
    before_action :set_params, only: [:vote, :upvoted]

    def vote
        @comment == "t" ? vote_comment : vote_submission
        redirect_to upvoted_path(id: @user.username, comment: @comment)
    end

    def upvoted
        @comment == "t" ? upvoted_comments : upvoted_submissions
    end

    private
        def set_params
            @id = params[:id]
            @comment = params[:comment]
            @how = params[:how]
            @user = User.find(current_user.id)
        end

        def vote_comment
            comment = Comment.find(@id)
            @how == "up" ? comment.upvotes += 1 : comment.upvotes -= 1
            if comment.save
                if @how == "up"
                    upvoted_comment = UpvotedComment.new(item_id: comment.id, user: @user)
                    upvoted_comment.save
                else
                    UpvotedComment.delete_by(item_id: comment.id, user: @user)
                end
            end
        end

        def vote_submission
            submission = Submission.find(@id)
            @how == "up" ? submission.upvotes += 1 : submission.upvotes -= 1
            if submission.save
                if @how == "up"
                    upvoted_submission = UpvotedSubmission.new(user: @user, item_id: submission.id)
                    upvoted_submission.save
                else
                    UpvotedSubmission.delete_by(item_id: submission.id, user: @user)
                end
            end
        end

        def upvoted_submissions
            @no_such_user = false
            if @user == nil
                @no_such_user = true
            else
                @submissions = Submission.newest.where(id: Upvoted.submissions(@user))
            end
            render "votes/submissions"
        end

        def upvoted_comments
            @comments = Comment.order(:created_at).where(id: Upvoted.comments(@user))
            render "votes/comments"
        end
end
