require 'rails_helper'

include Helpers

describe "User page" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    br=FactoryGirl.create(:brewery)
    b=br.beers.create name:"testi", style:"Lager"
    test=User.create username:"testi", password:"Testi1", password_confirmation:"Testi1"
    sign_in(username:"testi", password:"Testi1")
    b.ratings.create score:"50", user:test
    click_on("Sign out")
    sign_in(username:"Pekka", password:"Foobar1")
    b.ratings.create score:"10", user:user
    b.ratings.create score:"11", user:user
    b.ratings.create score:"12", user:user


  end


  it "has all the ratings from the user" do


    expect(Rating.count).to eq(4)
    visit user_path(user)

    expect(page).to have_content("Arvosteltuja oluita: #{user.ratings.count}")
    visit ratings_path
  end

  it "has a remove button that works" do
    visit user_path(user)


page.first(:link, "delete").click
    expect(Rating.count).to eq(3)
  end

  it "contains a favorite beer and favorite brewery section" do
    visit user_path(user)
    expect(page).not_to have_content("testi 50")
    expect(page).to have_content("Favorite beer: #{user.beers.first}")
    expect(page).to have_content("Favorite style: #{user.beers.first.style}")
    expect(page).to have_content("Favorite brewery: #{user.beers.first.brewery.name}")
    #save_and_open_page
  end
end
