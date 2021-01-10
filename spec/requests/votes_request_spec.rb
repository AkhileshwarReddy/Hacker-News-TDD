require 'rails_helper'

RSpec.describe "Votes", type: :request do
    describe "#vote", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { create(:submission, user: create(:user)) }
        let(:comment) { create(:comment, user: create(:user), submission: submission) }

        before(:each) do
            login_as(user)
        end

        it "should vote a submission" do
            visit vote_path(id: submission.id, how: "up")
            expect(page).to have_content(submission.title)
        end

        it "should unvote a submission" do
            visit vote_path(id: submission.id, how: "un")
            expect(page).to_not have_content(submission.title)
        end
        
        it "should vote a comment" do
            visit vote_path(id: comment.id, comment: "t", how: "up")
            expect(page).to have_content(comment.content)
        end
        
        it "should unvote a comment" do
            visit vote_path(id: comment.id, comment: "t", how: "un")
            expect(page).to_not have_content(comment.content)
        end
    end
end
