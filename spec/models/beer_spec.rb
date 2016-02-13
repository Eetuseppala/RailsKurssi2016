require 'rails_helper'

RSpec.describe Beer, type: :model do
  
  it "saves a beer if it has a name and a style" do
  	beer = Beer.create name:"Olut", style: "Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "doesn't save a beer without a name" do
  	beer = Beer.create style: "Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "doesn't save a beer without a style" do
  	beer = Beer.create name:"Olut"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
