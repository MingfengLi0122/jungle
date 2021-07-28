require 'rails_helper'

RSpec.feature "AddToCarts", ttype: :feature, js: true do
  before :each do 
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They will see update for the cart" do
    visit root_path

    click_button("Add", match: :first).click
    sleep 3

    puts page.html
    save_screenshot

    expect(page).to have_content " My Cart (1)"
  end

end
