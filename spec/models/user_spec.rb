require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation specs' do
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
end
