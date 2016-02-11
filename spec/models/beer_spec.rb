require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved with proper parameters" do
    beer = Beer.create name:"Testi", style:"Lager"
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not created without name" do
    beer= Beer.create style:"skrikidii"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created without style" do
    beer= Beer.create name:"skrikidii"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
