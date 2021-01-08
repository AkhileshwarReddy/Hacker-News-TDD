require 'rails_helper'

RSpec.describe HiddenSubmission, type: :model do
  let(:user) { create(:user) }
  describe "Validations" do
    let(:submissions) { build_list(:submission, rand(0..10), user: user) }

    it 'should have user' do
      hidden_submission = build(:hidden_submission, submission: submissions[rand(0..submissions.length)])
      expect(hidden_submission.save).to eq(false)
    end

    it 'should have submission' do
      hidden_submission = build(:hidden_submission, user: user)
      expect(hidden_submission.save).to eq(false)
    end
  end
  
end
