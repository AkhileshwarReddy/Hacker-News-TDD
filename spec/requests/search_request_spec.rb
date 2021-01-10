require 'rails_helper'

RSpec.describe "Searches", type: :request do
    describe "#search", type: :feature do
        let!(:submissions) { create_list(:submission, rand(1..20), user: create(:user)) }
        let!(:comments) { create_list(:comment, rand(10..20), user: create(:user), submission: submissions[rand(1..submissions.length-1)]) }
        let(:query) { [submissions[rand(1..submissions.length-1)].title, comments[rand(1..comments.length-1)].content].sample.split(' ').shuffle.pop }
        let(:submission_results) { submissions.select {|submission| submission.title.include?(query)} }
        let(:comment_results) { comments.select {|comment| comment.content.include?(query)} }

        before(:all) do
            Comment.reindex
            Submission.reindex
        end

        it "should display search results for both submissions and comments" do
            visit search_path

            fill_in "query", with: query

            form = find("#search")
            Capybara::RackTest::Form.new(page.driver, form.native).submit({})
            
            page.driver.refresh
            
            submission_results.each do |submission|
                expect(page).to have_content(submission.title)
            end

            comment_results.each do |comment|
                expect(page).to have_content(comment.content)
            end
        end

        it "should display search results for submission only" do
            visit search_path

            select "Stories", from: "type"

            form = find("#search")
            Capybara::RackTest::Form.new(page.driver, form.native).submit({})

            comment_results.each do |comment|
                expect(page).to_not have_content(comment.content)
            end
        end

        it "should display search results for comments only" do
            visit search_path(:query => query, :type => "comment")

            select "Comments", from: "type"

            form = find("#search")
            Capybara::RackTest::Form.new(page.driver, form.native).submit({})

            submission_results.each do |submission|
                expect(page).to_not have_content(submission.title)
            end
        end

        # pending "should display search results by date"

        # pending "should display search results by popularity"
        
        # pending "should display search results by time"

    end
end
