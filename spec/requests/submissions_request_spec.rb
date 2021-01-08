require 'rails_helper'

RSpec.describe "Submissions", type: :request do
    describe "#new", type: :feature do

      it "should render login page if user not signed in" do
        visit submit_path
        expect(page).to have_content('Login' || 'login')
      end
    end

    describe "#create" , type: :feature do
        let(:user) { create(:user) }

        before(:each) do
            login_as(user)
            visit submit_path
        end

        it "should create different types of submissions" do
            title = Faker::Lorem.paragraph(sentence_count: 1)
            text = [Faker::Lorem.paragraph(sentence_count: rand(0..100)), ""].sample
            url = text.empty? ? Faker::Internet.url : nil

            fill_in "submission_title", with: title
            fill_in "submission_url", with: url
            fill_in "submission_text", with: text

            click_link_or_button "submit"

            expect(current_path).to eq("/")
        end

        it 'should create text as comment if both url and text exists' do
            title = Faker::Lorem.paragraph(sentence_count: 1)
            text = Faker::Lorem.paragraph(sentence_count: rand(0..100))
            url = Faker::Internet.url

            fill_in "submission_title", with: title
            fill_in "submission_url", with: url
            fill_in "submission_text", with: text

            click_link_or_button "submit"
            
            submission = Submission.find_by(title: title, url: url)

            visit item_path(id: submission.id)
            expect(page).to have_content(text)
        end

        it "show render submit if no input" do
            click_link_or_button "submit"
            expect(current_path).to eq(submit_path)
        end
    end

    describe "#newest", type: :feature do
        let(:user) { create(:user) }
        let(:submissions) { create_list(:submission, rand(1..20), user: create(:user)) }
        let(:hidden_submissions) { create_list(:hidden_submission, rand(1..20), user: user, submission: create(:submission, user: create(:user))) }

        it "should not show hidden submissions if user signed in" do
            submissions_to_hide = submissions[0..4]
            submissions_to_hide.each do |submission|
                HiddenSubmission.create(user: user, submission: submission)
            end
            login_as(user)
            visit newest_path
            submissions_to_hide.each do |hidden_submission|
                expect(page).to_not have_content(hidden_submission.title)
            end
        end

        it "should show all the submissions if user not signed in" do
            submissions_to_hide = submissions[0..4]
            submissions_to_hide.each do |submission|
                HiddenSubmission.create(user: user, submission: submission)
            end
            
            visit newest_path
            
            submissions_to_hide.each do |hidden_submission|
                expect(page).to have_content(hidden_submission.title)
            end
        end
    end

    describe "#display_submission", type: :feature do
        let!(:user) { create(:user) }
        let!(:submission) { create(:submission, user: user) }
        let(:comments) { build_list(:comment, rand(1..5), user: create(:user)) }

        before(:each) do
            login_as(user)
            comments.each do |comment|
                comment.submission = submission
                comment.save
            end
        end

        it 'should display submission details' do
            visit item_path(id: submission.id)
            comments.each do |comment|
                expect(page).to have_content(comment.content)
            end
        end

        it 'should display no such item if thero is no id' do
            visit item_path
            expect(page).to have_content("No such item")
        end

        it 'should display no such item if id is invalid' do
            visit item_path(id: Faker::Internet.uuid)
            expect(page).to have_content("No such item")
        end

        it 'should display the newly added comment' do
            visit item_path(id: submission.id)

            content = Faker::Lorem.paragraph
            fill_in "comment_content", with: content

            click_link_or_button("add comment")

            expect(page).to have_content(content) 
        end
    end

    describe "#hide", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { create(:submission, user: user) }

        before(:each) do
            login_as(user) 
        end

        it "should hide the submission" do
            visit hide_path(:id => submission.id)
            expect(page).to_not have_content(submission.title)
        end

        it "should unhide the submission" do
           visit hide_path(:id => submission.id, :how => "un")
           visit "/"
           expect(page).to have_content(submission.title)
        end
    end
    
    describe "#hidden", type: :feature do
        let(:user) { create(:user) }
        let(:submission) { create(:submission, user: user) }

        it "should display all the hidden submissions" do
            login_as(user)
            submission = build(:submission, user: user)
            submission.save
            HiddenSubmission.create(user: user, submission: submission)
            visit hidden_path
            expect(page).to have_content(submission.title)
        end
    end
    
    describe "#askhn", type: :feature do
        let(:submissions) { build_list(:submission, rand(1..20), is_askhn: true, title: "Ask HN: #{Faker::Lorem.sentence}", user: create(:user)) }

        before(:each) do
            submissions.each { |submission| submission.save }
        end

        it "should display only Ask HN" do
            visit ask_path
            submissions.each do |submission|
                expect(page).to have_content(submission.title)
            end
        end
    end

    describe "#showhn", type: :feature do
        let(:submissions) { build_list(:submission, rand(1..20), is_showhn: true, title: "Show HN: #{Faker::Lorem.sentence}", user: create(:user)) }

        before(:each) do
            submissions.each { |submission| submission.save }
        end

        it "should display only Show HN" do
            visit show_path
            submissions.each do |submission|
                expect(page).to have_content(submission.title)
            end
        end
    end

    describe "#past", type: :feature do
        it "should display past submit" do

        end
    end
    
    describe "#shownew", type: :feature do
        it "should display latest Show HN" do
            visit shownew_path
            expect(current_path).to eq(shownew_path)
        end
    end

    describe "#submitted", type: :feature do
        let(:user) { create(:user) }
        let(:submissions) { build_list(:submission, rand(1..50), user: user) }

        before(:each) do
            submissions.each { |submission| submission.save } 
        end
        
        it "should display user submissions" do
            visit submitted_path(:id => user.username)
            submissions.each do |submission|
                expect(page).to have_content(submission.title)
            end
        end

        it "should display alert if there is no username" do
            visit submitted_path
            expect(page).to have_content("No such user")
        end

        it "should display alert if username is invalid" do
            visit submitted_path(:id => Faker::Internet.user_name)
            expect(page).to have_content("No such user")
        end
    end    
end
