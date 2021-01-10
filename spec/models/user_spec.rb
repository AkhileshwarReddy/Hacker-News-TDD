require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should have username' do
      user = build(:user, username: nil)
      expect(user.save).to eq(false)
    end

    it 'should have password' do
      user = build(:user, password: nil)
      expect(user.save).to eq(false)
    end

    it 'should have email' do
      user = build(:user, email: nil)
      expect(user.save).to eq(false)
    end
  end

  describe "Associations" do

    let(:user) { create(:user) }
    let(:submissions) { create_list(:submission, rand(1..20), user: user) }

    it 'should get all the submissions' do
      expect(submissions.count).to eq(user.submissions.count)
    end

    it "should get all the comments" do
      comments = create_list(:comment, rand(0..30), submission: submissions[rand(0..submissions.length)], user: user)
      expect(comments.count).to eq(user.comments.count)
    end
  end  
end
