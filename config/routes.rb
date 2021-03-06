FilmNett::Application.routes.draw {


  resources :users do
    member do
      get :following, :followers, :collection
    end
  end

  resources :movies

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :listed_movies, only: [:create, :destroy]
  resources :ratings, only: :update


  root 'static#feed'
  match '/test', to: 'test#new', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'post'
  match '/search_movie', to: 'search#search_movie', via: 'get'
  match '/movies/title/:search_title', to: 'movies#show_by_title', via: 'get'


}
