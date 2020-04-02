require 'rails_helper'

RSpec.describe "As a admin " , type: :feature do 

  describe "when I visit /admin/tutorials/new" do 

    before(:each) do 
      @admin = User.create!(email: 'admin@example.com', first_name: 'Bossy', last_name: 'McBosserton', password:  "password", role: :admin, status: :active)

      prework_tutorial_data = {
        "title"=>"Back End Engineering - Prework",
        "description"=>"Videos for prework.",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
        "classroom"=>false,
      }
    
      prework_tutorial = Tutorial.create! prework_tutorial_data

      mod_1_tutorial_data = {
        "title"=>"Back End Engineering - Module 1",
        "description"=>"Videos related to Mod 1.",
        "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
        "classroom"=>true,
      }

      m1_tutorial = Tutorial.create! mod_1_tutorial_data

      mod_3_tutorial_data = {
        "title"=>"Back End Engineering - Module 3",
        "description"=>"Video content for Mod 3.",
        "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
        "classroom"=>true,
        "tag_list"=>["Internet", "BDD", "Ruby"],
      }
    
      m3_tutorial = Tutorial.create! mod_3_tutorial_data

    end

    it "I can add new tutorials" do 
      
      expect(Tutorial.count).to eq(3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit '/admin/tutorials/new'
      
      fill_in 'tutorial[title]', with: "How to learn JavaScript in 20 mins"
      fill_in 'tutorial[description]', with: "It's not as hard as you think..."
      fill_in 'tutorial[thumbnail]', with: "https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg"

      click_on 'Save'

      expect(Tutorial.count).to eq(4)

      new_tutorial = Tutorial.last

      expect(new_tutorial.title).to eq("How to learn JavaScript in 20 mins")
      expect(new_tutorial.description).to eq("It's not as hard as you think...")
      expect(new_tutorial.thumbnail).to eq("https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg")

    end
      

  end

end
