require 'rails_helper'

include Helpers

describe "Beer" do


  it "is created with correct name" do
    visit new_beer_path
    fill_in('beer_name', with: "skrikidii")
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "is not created with empty name" do
    visit new_beer_path
    click_button('Create Beer')
    expect(page).to have_content("Name can't be blank")
    expect(Beer.count). to eq(0)
  end
end



def sop
save_and_open_page

end