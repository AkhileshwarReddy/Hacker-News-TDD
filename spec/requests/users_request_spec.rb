require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe "#user", type: :feature do
        it 'should display update form for current user profile' do
            user = create(:user)
            login_as(user)
            visit user_path(:id => user.username)
            expect(page).to have_selector(:link_or_button, "update")
        end

        it 'show display no such user if no id in the url' do
            visit user_path
            expect(page).to have_content("No such user")
        end

        it 'should not display update form for other user' do
            user = create(:user)
            visit user_path(:id => user.username)
            expect(page).to_not have_selector(:link_or_button, "update")
        end
    end

    describe "#update", type: :feature do
        before(:each) do
            user = create(:user)
            login_as(user)
            visit user_path(:id => user.username)
        end

        it 'should update about' do
            about = Faker::Lorem.paragraph(sentence_count: rand(0..10))
            fill_in "user_about", with: about
            click_link_or_button "update"

            expect(find_field("user_about").value).to eq(about)
        end

        it 'should update email' do
            email = Faker::Internet.safe_email
            fill_in "user_email", with: email
            click_link_or_button "update"

            expect(find_field("user_email").value).to eq(email)
        end

        it 'should update showdead, noprocrast' do
            showdead = ["yes", "no"].sample
            noprocrast = ["yes", "no"].sample

            select showdead, from: "user_showdead"
            select noprocrast,from: "user_noprocrast"

            click_link_or_button "update"
            
            expect(find_field("user_showdead").value).to eq((showdead == "yes" ? true : false).to_s)
            expect(find_field("user_noprocrast").value).to eq((noprocrast == "yes" ? true : false).to_s)
        end

        it 'should update user max visit, min away, delay' do
            max_visit = rand(10..100)
            min_away = rand(20..180)
            delay = rand(0..20)

            fill_in "user_max_visit", with: max_visit
            fill_in "user_minaway", with: min_away
            fill_in "user_delay", with: delay

            click_link_or_button "update"

            expect(find_field("user_max_visit").value).to eq(max_visit.to_s)
            expect(find_field("user_minaway").value).to eq(min_away.to_s)
            expect(find_field("user_delay").value).to eq(delay.to_s)
        end 
    end
end
