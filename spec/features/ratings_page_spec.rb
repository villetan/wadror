require 'rails_helper'

include Helpers

describe "Ratings page" do
  let!(:user) { FactoryGirl.create :user }

  it "shows the amount of ratings" do
    br=FactoryGirl.create(:brewery)
    b=br.beers.create name:"testi", style:"Lager"
    sign_in(username:"Pekka", password:"Foobar1")
    b.ratings.create score:"10", user:user
    b.ratings.create score:"11", user:user
    b.ratings.create score:"12", user:user
    visit ratings_path
    expect(page).to have_content("Number of ratings: #{Rating.count}")
    expect(Rating.count).to eq(3)
    expect(page).to have_content("#{Rating.first}")
  end
end