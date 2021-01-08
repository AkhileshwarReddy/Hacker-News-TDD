require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe "Validations" do
    let(:user) { create(:user) }
    let(:submission) { build(:submission) }

    it "should have title" do
      submission.title = nil
      submission.user = user
      expect(submission.save).to eq(false)
    end

    it "should have less than 2000 characters for text" do
      submission.text = Faker::Lorem.characters(number: 2001)
      submission.user = user
      expect(submission.save).to eq(false) 
    end

    it 'should have user' do
      expect(submission.save).to eq(false)
    end
  end

  describe 'Associations' do
    let!(:user) { User.first }
    let(:submission) { build(:submission) }

    it "should get all the comments of a submission" do
      comments = Comment.where(submission: submission)
      expect(comments.count).to eq(submission.comments.count)
    end
  end
end
