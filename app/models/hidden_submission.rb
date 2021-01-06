class HiddenSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :submission

  scope :submission_ids, ->(user) { where(user: user).map {|hs| hs.submission.id} }
end
