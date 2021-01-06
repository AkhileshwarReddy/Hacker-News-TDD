class Upvoted < ApplicationRecord
  belongs_to :user

  scope :submissions, ->(user) { where(type: "UpvotedSubmission", user: user).map {|submission| submission.item_id} }
  scope :comments, -> (user) { where(type: "UpvotedComment", user: user).map {|comment| comment.item_id} }
end
