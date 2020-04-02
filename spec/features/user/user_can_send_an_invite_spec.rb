require 'rails_helper'

RSpec.describe "As a logged in user" , type: :feature do 

  describe "when I fill out the form to send an invitation" do 

    it "the invitation is sent only if I entered a valid github handle" do 

      VCR.use_cassette('/user/user_can_send_an_invite') do

        user1 = User.create!(
                            email: 'dumortier.alexis@gmail.com', 
                            first_name: 'Alexis', 
                            last_name: 'Dumortier', 
                            password: 'temp', 
                            role: 0, 
                            token: ENV['GITHUB_USER1_TOKEN']
                            )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit '/dashboard'

        click_on 'Send an Invite'

        expect(current_path).to eq('/invite')
      
        an_invalid_github_account = 'adswqrdfgfg'

        fill_in :invite_github_handle, with: an_invalid_github_account

        click_on 'Send Invite'
        
        expect(current_path).to eq('/dashboard')

        expect(page).to have_content("The Github user you selected doesn't exist.")

        click_on 'Send an Invite'

        expect(current_path).to eq('/invite')

        a_valid_github_account = 'iEv0lv3'

        fill_in :invite_github_handle, with: a_valid_github_account

        click_on 'Send Invite'

        expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")

        expect(current_path).to eq('/dashboard')

        expect(page).to have_content("")

      end

    end
  end
end
