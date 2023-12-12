require 'rails_helper'

RSpec.describe 'User Dashboard Page' do 
  before(:each) do
    load_test_data
  end
  it "Show user's dashboard", :vcr do
    visit user_path(@user3)

    expect(page).to have_content("#{@user3.name}'s Dashboard")
    expect(page).to have_content(@user3.email)

    expect(page).to have_button("Discover Movies")

    within("div#user_parties") do
      expect(page).to have_content("These are your Viewing Parties")
      expect(page).to have_content("party1")
      expect(page).to have_content("party2")
    end
  end

  it "I should see the viewing parties that the user has been invited to with the following details:", :vcr do
    visit user_path(@user1.id)
    

    expect(page).to have_content("Attending Parties")

    expect(page).to have_content("party1")
    expect(page).to have_content("Movie Title: Star Wars")
    expect(page).to have_content("Date and Time: Starts on 2023/08/01 at 10:00")
    expect(page).to have_content("Hosted By: Capitainlearyo")
    expect(page).to have_content("Attending:")
    expect(page).to have_content("Slick Ric Bob")

    expect(page).to have_content("party2")
    expect(page).to have_content("Movie Title: The Lord of the Rings: The Fellowship of the Ring")
    expect(page).to have_content("Date and Time: Starts on 2023/09/01 at 11:00")
    expect(page).to have_content("Hosted By: Capitainlearyo")
    expect(page).to have_content("Attending:")
    expect(page).to have_content("Capitainlearyo Capitainlearyo Bob")

    expect(page).to have_content("Hosting Parties")
  end
end