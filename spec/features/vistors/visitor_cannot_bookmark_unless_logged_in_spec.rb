# Currently the Bookmark link will redirect to the login page and stop the video
# from playing which leads to a rather jarring experience.
#
# Let's display a message that says "User must login to bookmark videos."
# A tooltip or flash notice could be good options?
require 'rails_helper'

RSpec.describe 'As a visitor when I click the bookmark link' do
  it "shows a flash message stating 'You must log in to bookmark this'" do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)

    visit "/tutorials/#{tutorial1.id}?video_id=2"

    expect(page).to have_content(video1.title)
    expect(page).to have_content(video2.title)
    expect(page).not_to have_content(video3.title)
    expect(page).not_to have_content(video4.title)

    expect(page).to have_button('Bookmark', disabled: true)

    # text = find('.tooltip').hover
    # expect(text).to have_content('You must log in to bookmark this')
  end
end
