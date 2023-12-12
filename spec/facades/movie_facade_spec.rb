require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'top_rated', :vcr do
    results = MovieFacade.top_rated

    expect(results).to_not be_a(Hash)
    expect(results).to be_a(Array)

    movie_1 = results.first

    expect(movie_1).to respond_to(:backdrop_path)
    expect(movie_1.backdrop_path).to be_a(String)
    expect(movie_1).to respond_to(:genres)
    #expect(movie_1.genres).to be_a(Array)
    expect(movie_1).to respond_to(:id)
    expect(movie_1.id).to be_a(Integer)
    expect(movie_1).to respond_to(:overview)
    expect(movie_1.overview).to be_a(String)
    expect(movie_1).to respond_to(:popularity)
    expect(movie_1.popularity).to be_a(Float)
    expect(movie_1).to respond_to(:poster_path)
    expect(movie_1.poster_path).to be_a(String)
    expect(movie_1).to respond_to(:release_date)
    expect(movie_1.release_date).to be_a(String)
    expect(movie_1).to respond_to(:title)
    expect(movie_1.title).to be_a(String)
    expect(movie_1).to respond_to(:vote_average)
    expect(movie_1.vote_average).to be_a(Float)
    expect(movie_1).to respond_to(:vote_count)
    expect(movie_1.vote_count).to be_a(Integer)
  end

  it 'searched_movies', :vcr do
    results = MovieFacade.searched_movies("Django")

    expect(results).to_not be_a(Hash)
    expect(results).to be_a(Array)

    movie_1 = results.first

    expect(movie_1).to respond_to(:backdrop_path)
    expect(movie_1.backdrop_path).to be_a(String)
    expect(movie_1).to respond_to(:genres)
    #expect(movie_1.genres).to be_a(Array)
    expect(movie_1).to respond_to(:id)
    expect(movie_1.id).to be_a(Integer)
    expect(movie_1).to respond_to(:overview)
    expect(movie_1.overview).to be_a(String)
    expect(movie_1).to respond_to(:popularity)
    expect(movie_1.popularity).to be_a(Float)
    expect(movie_1).to respond_to(:poster_path)
    expect(movie_1.poster_path).to be_a(String)
    expect(movie_1).to respond_to(:release_date)
    expect(movie_1.release_date).to be_a(String)
    expect(movie_1).to respond_to(:title)
    expect(movie_1.title).to be_a(String)
    expect(movie_1).to respond_to(:vote_average)
    expect(movie_1.vote_average).to be_a(Float)
    expect(movie_1).to respond_to(:vote_count)
    expect(movie_1.vote_count).to be_a(Integer)
  end

  it 'movie_details', :vcr do
    movie_id = 123 
    details = MovieFacade.movie_details(movie_id)
    expect(details).to_not be_nil
    expect(details).to be_a Hash
    expect(details).to have_key :id
    expect(details[:id]).to be_a(Integer)
    expect(details).to have_key :poster_path
    expect(details[:poster_path]).to be_a(String)
  end

  it 'movie_cast', :vcr do
    movie_id = 123 
    cast = MovieFacade.movie_cast(movie_id)
    expect(cast).to_not be_nil
    cast = MovieService.movie_cast(268)
    expect(cast).to be_a Hash
    expect(cast[:cast].first).to have_key :id
    expect(cast[:cast].first[:id]).to be_a(Integer)
  end

  it 'movie_reviews', :vcr do
    movie_id = 123 
    reviews = MovieFacade.movie_reviews(movie_id)
    expect(reviews).to_not be_nil
    expect(reviews).to be_a Hash
    expect(reviews).to have_key :id
    expect(reviews[:id]).to be_a(Integer)
  end
end