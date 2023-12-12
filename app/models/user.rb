class User < ApplicationRecord
  has_secure_password
  validates_confirmation_of :password
  validates_presence_of :name
  validates_uniqueness_of :email, presence: true

  has_many :user_parties
  has_many :parties, through: :user_parties


  def list_parties
    movies = []  
    parties.uniq.each do |party|
      movies << MovieFacade.movie_details(party.movie_id)
    end
    movies 
  end
end