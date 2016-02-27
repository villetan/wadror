require 'rails_helper'

include Helpers

describe "Ratings page" do
  let!(:user) { FactoryGirl.create :user }

  it "shows the amount of ratings" do
    br=FactoryGirl.create(:brewery)
    b=br.beers.create name:"testi", style:(Style.create name:"Lager")
    sign_in(username:"Pekka", password:"Foobar1")
    b.ratings.create score:"10", user:user
    b.ratings.create score:"11", user:user
    b.ratings.create score:"12", user:user
    visit ratings_path
    expect(page).to have_content("Best beers")
    expect(page).to have_content("Best breweries")
    expect(page).to have_content("Best styles")
    expect(Rating.count).to eq(3)
    expect(page).to have_content("#{(Beer.where id:(Rating.first.beer_id)).first.name}")
    expect(page).to have_content("#{Rating.first.score}")
  end
end