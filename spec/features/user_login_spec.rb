require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    User.create!(
      first_name: "test",
      last_name: "one",
      email: "sometest@gmail.com",
      password: "111111",
      password_confirmation: "111111"
    )
  end

  scenario "Login with singed up user email" do

    visit root_path

    find_link("Login", match: :first).click
    sleep 3

    fill_in "email", :with => "sometest@gmail.com"
    fill_in "password", :with => "111111"

    click_on("Submit")
    sleep 3

    puts page.html
    save_screenshot

    expect(page).to have_content "Signed in as test"

  end  
end
