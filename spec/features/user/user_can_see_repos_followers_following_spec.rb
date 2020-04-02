require 'rails_helper'

RSpec.describe "As a logged in user" , type: :feature do 

  describe "When I visit /dashboard" do 

    it " I should see a section with my repositories" do 

      VCR.use_cassette('/user/user_can_see_list_of_repos') do

        user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user1 = User.create(user1_params)

        user2_params = {email: 'paul.@gmail.com', first_name: 'Paul', last_name: 'Debevec', password: 'temp', role: 0, token: ENV['GITHUB_USER2_TOKEN']}
        user2 = User.create(user2_params)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit '/dashboard'

        within('.github-repos') do 
          expect(page).to have_content('Github Repositories')
          expect(page).to have_css('.repo_title', count: 5)
          expect(first('.repo_title').text).to_not be_empty
        end

      end

    end

    it " I should see a section with my followers" do 

      VCR.use_cassette('/user/user_can_see_list_of_followers') do

        user_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user = User.create(user_params)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        user.list_followers.count  
        visit '/dashboard'

        within('.github-followers') do 
          expect(page).to have_content('Github Followers')
          expect(page).to have_css('.follower_name', count: user.list_followers.count)
          expect(first('.follower_name').text).to_not be_empty
        end

      end

    end

    it " I should see a section with the users I follow" do 

      VCR.use_cassette('/user/user_can_see_list_of_following') do

        user_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user = User.create(user_params)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within('.github-following') do 
          expect(page).to have_content('Github Following')
          expect(page).to have_css('.following_name', count: user.list_following.count)
          expect(first('.following_name').text).to_not be_empty
        end

      end

    end

  end

end
