require 'rails_helper'

RSpec.describe "As a logged in user " , type: :feature do 

  describe "When I visit the dashboard" do 

    it "I see a list of all my bookmarks" do 

      VCR.use_cassette('/user/user_can_see_bookmarks') do

        user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0, token: ENV['GITHUB_USER1_TOKEN']}
        user1 = User.create(user1_params)

        user2_params = {email: 'paul.@gmail.com', first_name: 'Paul', last_name: 'Debevec', password: 'temp', role: 0, token: ENV['GITHUB_USER2_TOKEN']}
        user2 = User.create(user2_params)

        tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
        tutorial1_videos = create_list(:video, 3, tutorial: tutorial1)

        tutorial2 = create(:tutorial, title: "How to put on your pants")
        tutorial2_video1 = create(:video, tutorial: tutorial2, position: 1)
        tutorial2_video2 = create(:video, tutorial: tutorial2, position: 4)
        tutorial2_video3 = create(:video, tutorial: tutorial2, position: 3)

        tutorial3 = create(:tutorial, title: "How to put on your pants")
        video3 = create_list(:video, 3, tutorial: tutorial3)

        UserVideo.create!(user_id: user1.id ,video_id: tutorial2_video2.id)
        UserVideo.create!(user_id: user1.id ,video_id: tutorial2_video3.id)
        UserVideo.create!(user_id: user1.id ,video_id: tutorial1_videos[0].id)
        UserVideo.create!(user_id: user1.id ,video_id: video3[2].id)

        UserVideo.create!(user_id: user2.id ,video_id: tutorial1_videos[1].id)
        UserVideo.create!(user_id: user2.id ,video_id: tutorial1_videos[2].id)
        UserVideo.create!(user_id: user2.id ,video_id: tutorial2_video1.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit '/dashboard'

        within('section#bookmarks') do 
          expect(page).to have_content('Bookmarked Segments')
          expect(page).to have_content("#{tutorial1.title} - #{tutorial1_videos[0].title}\n#{tutorial2.title} - #{tutorial2_video3.title}\n#{tutorial2.title} - #{tutorial2_video2.title}\n#{tutorial3.title} - #{video3[2].title}")
          expect(page).to_not have_content("#{tutorial1_videos[1].title}")
          expect(page).to_not have_content("#{tutorial1_videos[2].title}")
          expect(page).to_not have_content("#{tutorial2_video1.title}")
        end

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

        visit '/dashboard'

        within('section#bookmarks') do 
          expect(page).to have_content('Bookmarked Segments')
          expect(page).to have_content("#{tutorial1.title} - #{tutorial1_videos[1].title}\n#{tutorial1.title} - #{tutorial1_videos[2].title}\n#{tutorial2.title} - #{tutorial2_video1.title}")
          expect(page).to_not have_content("#{tutorial1_videos[0].title}")
          expect(page).to_not have_content("#{tutorial2_video3.title}")
          expect(page).to_not have_content("#{tutorial2_video2.title}")
          expect(page).to_not have_content("#{video3[2].title}")
        end

      end

    end


  end

end