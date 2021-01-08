require 'rails_helper'

RSpec.describe "Comments", type: :request do
    describe "#create", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { build(:submission, user: create(:user)) }

        it "should create a comment" do
            login_as(user)
            submission.save
            content = Faker::Lorem.sentence

            page.driver.post comment_create_path(:id => submission.id), {:comment => { :content => content } }
            visit item_path(id: submission.id)
            
            expect(page).to have_content(content)
        end
    end

    describe "#reply", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { create(:submission, user: create(:user)) }
        let(:comment) { build(:comment, submission: submission, user: user) }

        it "should reply to a comment" do
            comment.save
            login_as(user)
            content = Faker::Lorem.sentence
            page.driver.post reply_path(:id => comment.id, :content => content)
            visit item_path(id: submission.id)

            expect(page).to have_content(content)
        end
    end

    describe "#show", type: :feature do
        let(:submission) { create(:submission, user: create(:user)) }
        let(:comment) { create(:comment, user: create(:user), submission: submission) }

        it "should display comment details" do
            visit comment_path(id: comment.id)
            expect(page).to have_content(comment.content)
        end
    end

    describe "#new_comments", type: :feature do
        let!(:submissions) { create_list(:submission, rand(1..20), user: create(:user)) }
        let!(:comments) { create_list(:comment, rand(1..50), submission: submissions[rand(0..submissions.length)], user: create(:user)) }

        it "should display all the new comments" do
            visit newcomments_path

            comments.each do |comment|
                expect(page).to have_content(comment.content)
            end
        end
    end

    describe "#threads", type: :feature do
        let(:user) { create(:user) }
        let!(:submissions) { create_list(:submission, rand(1..20), user: create(:user)) }
        let!(:comments) { create_list(:comment, rand(1..10), submission: submissions[rand(0..submissions.length)], user: [user, create(:user)].sample) }

        it "should display all the threads involved" do
            login_as(user)
            visit threads_path
            user_comments = comments.select { |comment| comment.user == user }
            user_comments.each do |comment|
                expect(page).to have_content(comment.content)
            end
        end

    end
end
