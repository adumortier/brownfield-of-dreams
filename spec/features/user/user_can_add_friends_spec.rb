require 'rails_helper'

RSpec.describe "As a logged in user" , type: :feature do 

  describe "When I add another user to my friend list" do 

    before(:each) do 
      user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
      @user1 = User.create(user1_params)

      user2_params = {email: 'paul.@gmail.com', first_name: 'Paul', last_name: 'Debevec', password: 'temp', role: 0, token: ENV['GITHUB_USER2_TOKEN']}
      @user2 = User.create(user2_params)
    end

    it "I see this user in my list of friends" do 
      
      VCR.use_cassette('/user/can_add_friends') do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
        visit '/dashboard'

        within('section#friends') do 
          expect(page).to_not have_content('PaulDebevec')
        end

        within('section#github-followers') do 
          within('span#PaulDebevec') do 
            click_button 'Add as Friend'
          end
        end

        expect(current_path).to eq('/dashboard')

        within('section#friends') do 
          expect(page).to have_content('Paul Debevec')
        end
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
        
        visit '/dashboard'
        
        within('section#friends') do 
          expect(page).to have_content('Alexis Dumortier')
        end

      end

    end

  end

end