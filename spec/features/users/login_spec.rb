require "rails_helper"

RSpec.describe "User Login" do
  before(:each) do
    load_test_data
  end

  it "successful login will take you to dashboard" do
    user = User.create(name: "John", email: "abcd@gmail.com", password: "testing123")

    visit root_path

    expect(page).to have_button("Login")
    click_button("Login")

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button("Login")

    expect(current_path).to eq(user_path(user))
  end

  it "SAD-PATH: will return user to login page for faulty info" do
    user = User.create(name: "John", email: "abcd@gmail.com", password: "testing123")

    visit root_path

    expect(page).to have_button("Login")
    click_button("Login")

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in :email, with: user.email
    fill_in :password, with: "Not it!"
    click_button("Login")

    expect(page).to have_content("Sorry, your credentials are bad")
    expect(current_path).to eq(login_path)
  end
end