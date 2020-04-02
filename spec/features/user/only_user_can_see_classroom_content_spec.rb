require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit the welcome page' do
    it "I only the classroom content if I'm logged in" do
      prework_tutorial_data = {
        'title' => 'Back End Engineering - Prework',
        'description' => 'Videos for prework.',
        'thumbnail' => 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg',
        'playlist_id' => 'PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5',
        'classroom' => false
      }

      prework_tutorial = Tutorial.create! prework_tutorial_data

      mod_1_tutorial_data = {
        'title' => 'Back End Engineering - Module 1',
        'description' => 'Videos related to Mod 1.',
        'thumbnail' => 'https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg',
        'playlist_id' => 'PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb',
        'classroom' => true
      }

      m1_tutorial = Tutorial.create! mod_1_tutorial_data

      mod_3_tutorial_data = {
        'title' => 'Back End Engineering - Module 3',
        'description' => 'Video content for Mod 3.',
        'thumbnail' => 'https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg',
        'playlist_id' => 'PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ',
        'classroom' => true,
        'tag_list' => ['Internet', 'BDD', 'Ruby']
      }

      m3_tutorial = Tutorial.create! mod_3_tutorial_data

      visit '/'

      within("div#tutorial-#{prework_tutorial.id}") do
        expect(page).to have_link(prework_tutorial.title)
      end

      within("div#tutorial-#{m1_tutorial.id}") do
        expect(page).to have_content('[Classroom Content]')
      end

      within("div#tutorial-#{m3_tutorial.id}") do
        expect(page).to have_content('[Classroom Content]')
      end

      user1_params = { email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN'] }
      @user1 = User.create(user1_params)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/'

      within("div#tutorial-#{prework_tutorial.id}") do
        expect(page).to have_link(prework_tutorial.title)
      end

      within("div#tutorial-#{m1_tutorial.id}") do
        expect(page).to have_link(m1_tutorial.title)
      end

      within("div#tutorial-#{m3_tutorial.id}") do
        expect(page).to have_link(m3_tutorial.title)
      end
    end
  end
end
