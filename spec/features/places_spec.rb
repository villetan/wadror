require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1, street:"Kustaa vaasan katu", status:"Brewery", city:"Helsinki", zip:"00560", country:"Finland", overall:"90" ) ]
    )

    visit places_path

    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if many is returned by the API, then all of them are shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1, street:"Kustaa vaasan katu", status:"Brewery", city:"Helsinki", zip:"00560", country:"Finland", overall:"90"  ) ,
          Place.new( name:"Parmesan", id: 2, street:"Intiankatu", status:"Pizza", city:"Helsinki", zip:"00560", country:"Finland", overall:"95")  ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Intiankatu"
  end

  it "if none is returned by the API, then error message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"

  end
end