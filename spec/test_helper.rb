def load_test_data
  @user1 = User.create!(name: "Capitainlearyo", email: "example1@yahoo.com", password: "test")
  @user2 = User.create!(name: "Slick Ric", email: "uhhh@gmail.com", password: "test")
  @user3 = User.create!(name: "Bob", email: "Bob@a_website.com", password: "test")

  @party1 = @user1.parties.create!(name: "party1", movie_id: 11, movie_title: "Star Wars", duration: 120, date: '2023/08/01', start_time: '10:00')
  @party2 = @user1.parties.create!(name: "party2", movie_id: 120, movie_title: "LOTR", duration: 180, date: '2023/09/01', start_time: '11:00')
  @party3 = @user2.parties.create!(name: "party3", movie_id: 20, movie_title: "Goblin", duration: 160, date: '2021/11/15', start_time: '11:00')

  @user_party1 = @user1.user_parties.create!(party_id: @party1.id, host: true)
  @user_party2 = @user2.user_parties.create!(party_id: @party1.id, host: false)
  @user_party3 = @user3.user_parties.create!(party_id: @party1.id, host: false) 
  @user_party4 = @user2.user_parties.create!(party_id: @party2.id, host: true)
  @user_party5 = @user1.user_parties.create!(party_id: @party2.id, host: false)
  @user_party6 = @user3.user_parties.create!(party_id: @party2.id, host: false)
  @user_party7 = @user2.user_parties.create!(party_id: @party3.id, host: true)
end