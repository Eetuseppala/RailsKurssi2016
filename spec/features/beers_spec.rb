require 'rails_helper'

include Helpers

describe "New beer page" do

let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  it "can create a new beer" do
    visit new_beer_path
    fill_in('beer[name]', with:'Kalja')
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "doesn't save a beer with invalid name" do
    visit new_beer_path

    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style]')

	expect{
      click_button "Create Beer"
    }.to_not change{Beer.count}

	expect(page).to have_content "Name can't be blank"
  end
end