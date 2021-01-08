require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Validations" do
    let(:user) { create(:user) }
    let(:submission) { build(:submission) }

    before(:each) do
      submission.user = user
      submission.save
    end

    it "should have content" do
      comment = build(:comment, content: nil, user: user, submission: submission)
      expect(comment.save).to eq(false)
    end

    it "should have submission" do
      comment = build(:comment, user: user)
      expect(comment.save).to eq(false)
    end

    it "should have comment level" do
      comment = build(:comment, user: user, submission: submission, level: nil)
      expect(comment.save).to eq(false)
    end

    it "should have user" do
      comment = build(:comment, submission: submission)
      expect(comment.save).to eq(false)
    end

    it 'should create a child comment' do
      parent_comment = create(:comment, user: user, submission: submission)
      expect(Comment.create_child_comment(Faker::Lorem.sentence, parent_comment.id, user)).to eq(parent_comment.upvotes += 1)
    end
  end

  describe "Associations" do
    
  end
end
