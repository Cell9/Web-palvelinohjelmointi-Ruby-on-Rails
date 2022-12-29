require 'rails_helper'

include Helpers

describe "Beers page" do

    before :each do
        FactoryBot.create :user
        FactoryBot.create :brewery
    end

    it "is created when name is valid" do
        visit new_beer_path

        fill_in('beer_name', with: 'BeerX')
        click_button('Create Beer')
        expect(page).to have_content 'Beer was successfully created'
        expect(page).to have_content 'BeerX'
    end

    it "is not created when name is invalid" do
        visit new_beer_path

        click_button('Create Beer')
        expect(page).to have_content 'New beer'
        expect(page).to have_content 'Back to beers'
    end

end