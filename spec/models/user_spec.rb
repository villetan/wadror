require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "is not saved with a password that is too short" do
    user = User.create username:"Pekka", password:"Aa1", password_confirmation:"Aa1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password made out of lowercase" do
    user = User.create username:"Pekka", password:"aasi", password_confirmation:"aasi"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(user, 10)
      best = create_beer_with_rating(user, 25)
      create_beer_with_rating(user, 7)

      expect(user.favorite_beer).to eq(best)
    end
  end



end

RSpec.describe User, type: :model do
  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "returns nil if ratings empty" do

      expect(user.favorite_style).to eq(nil)

    end

    it "is correct with one rating" do
      fav=Beer.create name:"test", style:"Lager"
      Rating.create score:50, beer:fav, user:user
      expect(user.favorite_style).to eq('Lager')
    end

    it "is correct with multiple ratings" do
      beer1=Beer.create name:"test", style:"Lager"
      beer2=Beer.create name:"test1", style:"Porter"
      beer3=Beer.create name:"test2", style:"Lager"
      Rating.create score:1, beer:beer1, user:user
      Rating.create score:49, beer:beer2, user:user
      Rating.create score:1, beer:beer3, user:user
      expect(user.favorite_style). to eq('Porter')
    end
  end
end

RSpec.describe User, type: :model do
  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }


    it "returns nil if ratings empty" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "return the only brewery if only one rated" do
      brewery1= Brewery.create name:"asd", year:1999
      beer1=Beer.create name:"test", style:"Lager", brewery:brewery1
      Rating.create score:30, beer:beer1, user:user
      expect(user.favorite_brewery.name).to eq(brewery1.name)
    end

    it "returns the brewery with the best average rating" do
      brewery1= Brewery.create name:"asd", year:1999
      brewery2= Brewery.create name:"kek", year:1999
      beer1=Beer.create name:"test", style:"Lager", brewery:brewery1
      beer2=Beer.create name:"skrikidii", style:"Lager", brewery:brewery2
      Rating.create score:30, beer:beer1, user:user
      Rating.create score:50, beer:beer2, user:user
      expect(user.favorite_brewery.name).to eq(brewery2.name)
    end
  end
end



def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end
