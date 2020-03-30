require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'visitors only see non-classroom videos' do
    classroom_tut_1 = create(:tutorial, classroom:true)
    classroom_tut_2 = create(:tutorial, classroom:true)
    free_tutorial_1 = create(:tutorial)
    free_tutorial_2 = create(:tutorial)

    visit '/'

    within("#tutorials") do
      within("#tutorial-#{free_tutorial_1.id}") do
        expect(page).to have_link(free_tutorial_1.title)
      end
      within("#tutorial-#{free_tutorial_2.id}") do
        expect(page).to have_link(free_tutorial_2.title)
      end
      within("#tutorial-#{classroom_tut_1.id}") do
        expect(page).not_to have_link(classroom_tut_1.title)
        expect(page).to have_content("Classroom Content")

      end
      within("#tutorial-#{classroom_tut_2.id}") do
        expect(page).not_to have_link(classroom_tut_2.title)
        expect(page).to have_content("Classroom Content")
      end
    end

  end
end
