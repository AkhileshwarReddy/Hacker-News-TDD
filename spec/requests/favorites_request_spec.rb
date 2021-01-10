require 'rails_helper'

RSpec.describe "Favorites", type: :request do

    describe "#index", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { create(:submission, user: create(:user)) }
        let(:comment) { create(:comment, submission: submission, user: create(:user)) }

        before(:each) do
            login_as(user)
        end

        it "should set a submission as favorite" do
            visit fave_path(id: submission.id)
            expect(page).to have_text(submission.title)
        end

        it "should remove a submission from favorites" do
            visit fave_path(id: submission.id, how: "un")
            expect(page).to_not have_content(submission.title)
        end

        it "should set a comment as favorite" do
            visit fave_path(id: comment.id, comment: "t")
            expect(page).to have_content(comment.content)
        end

        it "should remove a comment from favorites" do
            visit fave_path(id: comment.id, comment: "t", how: "un")
            expect(page).to_not have_content(comment.content)
        end
    end
    
end
