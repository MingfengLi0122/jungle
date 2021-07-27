require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    before(:each) do
      @user = User.new(first_name: "Sam", last_name: "Jackson",email: "test@gmail.com", password: "123123", password_confirmation: "123123")
    end

    it "saves a user when fields are valid" do
      expect(@user.save).to eq true
    end

    it "fail to save when name is not valid" do 
      @user.first_name = nil
      @user.save
      
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "fail to save when email is not valid" do 
      @user.email = nil
      @user.save
      
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it "fail to save when password is not valid" do 
      @user.password = "321321"
      @user.password_confirmation = "123123"
      @user.save
     
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
    end

    it "fail to save when password is not valid" do 
      @user.password = "3"
      @user.password_confirmation = "1"
      @user.save
      
      expect(@user.save).to eq false
      expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password", "Password is too short (minimum is 3 characters)"]
    end

    it "fail to save when email is not unique" do
      @user.save
      @user1 = User.new(first_name: "Tim", last_name: "Lee", email: "TEST@GMAIL.com", password: "111111", password_confirmation: "111111")
      @user1.save
      expect(@user1.save).to eq false
      expect(@user1.errors.full_messages).to eq ["Email has already been taken"]
    end 
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(first_name: "Sam", last_name: "Jackson",email: "test@gmail.com", password: "123123", password_confirmation: "123123")
    end

    it "return user if authentication passed" do 
      @user.save
      @result = User.authenticate_with_credentials("test@gmail.com", "123123")
      
      expect(@user.save).to eq true
      expect(@result).to_not eq nil
    end

    it "return nil if authentication failed because of wrong email address " do 
      @user.save
      @result = User.authenticate_with_credentials("123@gmail.com", "123123")
      
      expect(@user.save).to eq true
      expect(@result).to eq nil
    end

    it "return nil if authentication failed because of wrong password" do 
      @user.save
      @result = User.authenticate_with_credentials("test@gmail.com", "222222")
      
      expect(@user.save).to eq true
      expect(@result).to eq nil
    end

    it "return user if authentication because of wrong password" do 
      @user.save
      @result = User.authenticate_with_credentials("TeST@gmail.com", "123123")
      
      expect(@user.save).to eq true
      expect(@result).to_not eq nil
    end
    
  end
end
