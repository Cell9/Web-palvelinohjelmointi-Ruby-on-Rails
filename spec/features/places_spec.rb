require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "multiple results are shown on page" do
    allow(BeermappingApi).to receive(:places_in).with("Lohja").and_return(
      [ Place.new( name: "Puisto", id: 1 ), Place.new( name: "Rock-bar", id: 2 ),Place.new( name: "Ojamon räkälä", id: 3 ) ]
    )

    visit places_path
    fill_in('city', with: 'Lohja')
    click_button "Search"

    expect(page).to have_content "Puisto"
    expect(page).to have_content "Rock-bar"
    expect(page).to have_content "Ojamon räkälä"
  end

  it "multiple results are shown on page" do
    allow(BeermappingApi).to receive(:places_in).with("turku").and_return( [] )

    visit places_path
    fill_in('city', with: 'turku')
    click_button "Search"

    expect(page).to have_content "No locations in turku"
  end

end