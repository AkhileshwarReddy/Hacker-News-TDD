class Submission < ApplicationRecord
    searchkick
    belongs_to :user
    has_many :comments, dependent: :destroy

    validates :title, presence: true
    validates :text, length: { maximum: 2000 }

    def self.newest
        self.order(created_at: :desc)
    end

    def self.by_date(date = Date.yesterday.strftime("%Y-%m-%d"))
        @submissions = self.where(created_at: Date.parse(date).all_day)
    end
end
