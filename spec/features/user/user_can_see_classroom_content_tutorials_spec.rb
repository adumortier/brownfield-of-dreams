require 'rails_helper'

RSpec.describe 'Logged in users see a video show', type: :feature do
  it 'users see both non-classroom, and classroom tutorial videos' do
    classroom_tut_1 = create(:tutorial, classroom:true)
    classroom_tut_2 = create(:tutorial, classroom:true)
    free_tutorial_1 = create(:tutorial)
    free_tutorial_2 = create(:tutorial)

    VCR.use_cassette('/user/user_can_see_classroom_tutorials') do

    user1_params = {  email: 'dumortier.alexis@gmail.com',
                      first_name: 'Alexis',
                      last_name: 'Dumortier',
                      password_digest: 'temp',
                      role: 0,
                      token: ENV['GITHUB_USER1_TOKEN'] }

    user1 = User.create(user1_params)

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(user1)

    visit '/'

    within("#tutorials") do
      expect(page).to have_link(free_tutorial_1.title)
      expect(page).to have_link(free_tutorial_2.title)
      expect(page).to have_link(classroom_tut_1.title)
      expect(page).to have_link(classroom_tut_2.title)
    end
    end
  end
end
