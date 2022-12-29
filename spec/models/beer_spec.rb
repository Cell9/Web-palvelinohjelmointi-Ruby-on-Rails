require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:test_brewery) { Brewery.new name: "Panimo", year: 2000 }

  it "is not saved without a name" do
    beer = Beer.create style: "Lager", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name: "Koff", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is saved when it has a name, a style and a brewery" do
    beer = Beer.create name: "Koff", style: "Lager", brewery: test_brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end
