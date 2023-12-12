require 'rails_helper'

RSpec.describe 'User Registration Page' do 
  before(:each) do
    load_test_data
  end

  it 'When a user visits the register path they should see a form to register.' do

    visit root_path
    expect(page).to have_link("Capitainlearyo")
    expect(page).to have_link("Slick Ric")
    expect(page).to have_link("Bob")

    expect(page).to have_button("Create a New User")
    click_button "Create a New User"
    expect(current_path).to eq(register_path)
    
    fill_in "Name:", with: "Jon"
    fill_in "Email:", with: "Jon@a_website.com"
    fill_in "Password:", with: "test"
    fill_in "Confirm Password:", with: "test"

    click_button "Register"
    
    expect(page).to have_content("Jon's Dashboard")

    visit root_path

    expect(page).to have_link("Capitainlearyo")
    expect(page).to have_link("Slick Ric")
    expect(page).to have_link("Bob")
    expect(page).to have_link("Jon")
  end

  describe '#sad_path' do
    it 'NAME - missing user attribute' do
      visit register_path

      fill_in "Name", with: ""
      fill_in "Email", with: "example@example.com"
      fill_in "Password:", with: "test"
      fill_in "Confirm Password:", with: "test"
      click_button "Register"

      expect(page).to have_content("Name nor Email can be blank")
      expect(page).to_not have_content('Email is already taken. Please choose a different one.')
      expect(current_path).to eq(register_path)
    end

    it 'EMAIL - missing user attribute' do
      visit register_path

      fill_in "Name", with: "Sherlock"
      fill_in "Email", with: ""
      fill_in "Password:", with: "test"
      fill_in "Confirm Password:", with: "test"
      click_button "Register"

      expect(page).to have_content("Name nor Email can be blank")
      expect(page).to_not have_content('Email is already taken. Please choose a different one.')
      expect(current_path).to eq(register_path)
    end

    it 'NAME & EMAIL - missing user attribute' do
      visit register_path

      fill_in "Name", with: ""
      fill_in "Email", with: ""
      fill_in "Password:", with: "test"
      fill_in "Confirm Password:", with: "test"
      click_button "Register"

      expect(page).to have_content("Name nor Email can be blank")
      expect(page).to_not have_content('Email is already taken. Please choose a different one.')
      expect(current_path).to eq(register_path)
    end

    it "Cannot have a duplicate email" do
      visit register_path

      fill_in "Name", with: "Sherlock"
      fill_in "Email", with: "example1@yahoo.com"
      fill_in "Password:", with: "test"
      fill_in "Confirm Password:", with: "test"
      click_button "Register"

      expect(page).to have_content('Email is already taken. Please choose a different one.')
      expect(page).to_not have_content("Name nor Email can be blank")
      expect(current_path).to eq(register_path)
    end

    it "has matching passwords" do
      visit register_path

      fill_in "Name", with: "Sherlock"
      fill_in "Email", with: "example1@yahoo.com"
      fill_in "Password:", with: "test"
      fill_in "Confirm Password:", with: "test12"
      click_button "Register"

      expect(page).to have_content('Passwords must match')
      expect(page).to_not have_content("Name nor Email can be blank")
      expect(current_path).to eq(register_path)
    end
  end
end