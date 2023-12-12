Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'welcome#index'

  resources :users, only: [:new, :create, :show] do
    # resources :discover, only: [:index]
  end
  get "/register", to: "users#register"
  post "/register", to: "users#create"
# make an alias for register ---> new
  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"

  get "/users/:id/discover", to: "movies#index"
  get "/users/:id/movies", to: "movies#search"
  get "/users/:id/movies/:movie_id", to: "movies#show"

  get "/users/:user_id/movies/:movie_id/viewing_party/new", to: "parties#new"
  post "/users/:user_id/movies/:movie_id/viewing_party", to: "parties#create"
end
