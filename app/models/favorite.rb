class Favorite < ApplicationRecord
  belongs_to :user

  scope :submissions, ->(user) { where(:type => "FavoriteSubmission", :user => user).map { |submission| submission.item_id } }
  scope :comments, ->(user) { where(:type => "FavoriteComment", :user => user).map { |comment| comment.item_id } }
end
