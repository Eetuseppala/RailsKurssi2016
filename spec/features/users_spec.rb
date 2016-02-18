require 'rails_helper'

include Helpers

describe "User" do
  before :each do
  FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and password do not match'
    end

    it "has correct ratings on the user's page" do

      user = FactoryGirl.create :user, username: "Joku"
      user2 = FactoryGirl.create :user, username: "Jokutoinen"

      panimo = FactoryGirl.create :brewery, name:"Koff"

      kalja = FactoryGirl.create :beer, name:"Karhu", brewery: panimo
      kalja2 = FactoryGirl.create :beer, name:"Kalja", brewery: panimo
      
      r = FactoryGirl.create(:rating)
      r2 = FactoryGirl.create(:rating)

      user.ratings << r
      user2.ratings << r2

      kalja.ratings << r
      kalja2.ratings << r2

      sign_in(username:"Joku", password:"Foobar1")

      expect(page).to have_content "Has made 1 rating"
      expect(page).to have_content "Karhu"
      expect(page).not_to have_content "Kalja"
    end

    it "can delete a rating" do

      user = FactoryGirl.create :user, username: "Joku"
      panimo = FactoryGirl.create :brewery, name:"Koff"
      kalja = FactoryGirl.create :beer, name:"Karhu", brewery: panimo
      r = FactoryGirl.create(:rating)

      user.ratings << r
      kalja.ratings << r

      sign_in(username:"Joku", password:"Foobar1")

      click_on 'delete'

      expect(page).to have_content "Has made 0 ratings"
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  
end

def confirm_dialog
  page.driver.browser.accept_js_confirms
end