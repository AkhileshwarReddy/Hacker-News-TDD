require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  describe "Comment Level" do
    it 'should generate comment level' do
      expect(helper.generate_comment_level("1", 8)).to eq("1.9")
      expect(helper.generate_comment_level("1.2")).to eq("1.2.1")
      expect(helper.generate_comment_level("4.9.8", 16)).to eq("4.9.8.17")
    end
  end
  
end
