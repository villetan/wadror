require 'rails_helper'

include Helpers

describe "Beer" do


  it "is created with correct name" do
    visit new_beer_path
    expect(page).to have_content("you should be signed in")
  end

  it "is not created with empty name" do
    visit new_beer_path
    expect(page).not_to have_content("Create Beer")
    expect(page).to have_content("you should be signed in")
    expect(Beer.count). to eq(0)
  end
end



def sop
save_and_open_page

end