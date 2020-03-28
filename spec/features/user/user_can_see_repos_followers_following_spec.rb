require 'rails_helper'

RSpec.describe "As a logged in user" , type: :feature do 

  describe "When I visit /dashboard" do 

    it " I should see a section with my repositories" do 

      VCR.use_cassette('/user/user_can_see_list_of_repos') do

      user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password_digest: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
      user1 = User.create(user1_params)

      user2_params = {email: 'paul.@gmail.com', first_name: 'Paul', last_name: 'Debevec', password_digest: 'temp', role: 0, token: ENV['GITHUB_USER2_TOKEN']}
      user2 = User.create(user2_params)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within('section#github-repos') do 
        expect(page).to have_content('Github Repositories')
        expect(page).to have_link('activerecord-obstacle-course')
        expect(page).to have_link('adopt_dont_shop')
        expect(page).to have_link('algorithm_sort')
        expect(page).to have_link('b2-mid-mod')
        expect(page).to have_link('backend_module_0_capstone')
        expect(page).to_not have_link('battleship')
        expect(page).to_not have_link('aa_test')
      end

    end

    end

    it " I should see a section with my followers" do 

      VCR.use_cassette('/user/user_can_see_list_of_followers') do

        user_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password_digest: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user = User.create(user_params)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within('section#github-followers') do 
          expect(page).to have_content('Github Followers')
          expect(page).to have_link('iEv0lv3')
          expect(page).to have_link('PaulDebevec')
          expect(page).to have_link('rob-chen')
          expect(page).to have_link('tatanne2020')
        end


      end

    end

    it " I should see a section with the users I follow" do 

      VCR.use_cassette('/user/user_can_see_list_of_following') do

        user_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password_digest: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user = User.create(user_params)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within('section#github-following') do 
          expect(page).to have_content('Github Following')
          expect(page).to have_link('rob-chen')
          expect(page).to have_link('iEv0lv3')
          expect(page).to have_link('BrianZanti')
          expect(page).to have_link('dionew1')
          expect(page).to have_link('PaulDebevec')
        end

      end

    end

  end

end
