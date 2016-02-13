require 'rails_helper'

include Helpers

describe "New beer page" do
  it "can create a new beer" do
    visit new_beer_path
    fill_in('beer[name]', with:'Kalja')
    select('Koff', from:'brewery[beer_id]')
    select('Lager', from:'style')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    save_and_open_page
  end
end