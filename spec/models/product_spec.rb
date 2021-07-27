require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before(:each) do 
      @category = Category.new(name: "toy")
      @product = @category.products.new(name: "car", price: 200, quantity: 50)
    end

    it "saves a product when fields are valid" do
      expect(@product.save).to eq true
    end

    it "fail to save when name is missing" do
      @product.name = nil
      @product.save
    
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it "fail to save when price is missing" do 
      @product.price_cents = nil
      @product.save
      
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
    end  
    
    it "fail to save when quantity is missing" do 
      @product.quantity = nil
      @product.save
      
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
    end 

    it "fail to save when category is missing" do 
      @product.category = nil
      @product.save
     
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end 
  end
end
