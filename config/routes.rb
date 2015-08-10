Twitchquotes::Application.routes.draw do
  # resources :users
  resources :quotes do
    get 'search', on: :collection
    get 'marked', on: :collection
    get 'ascii-art', on: :collection, to: 'quotes#ascii_art', as: 'ascii_art'
    get 'show_marked_quote', on: :member
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :streams, only: [:index, :show]
  resources :announcements, only: [:index, :create, :update, :edit, :new]
  resources :likes, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy]
  resources :ip_likes, only: [:create, :destroy]
  resources :random, only: [:index, :show]
  resources :users, only: [:new, :create, :show]
  resources :admin, only: [:index]

  root to: 'quotes#index'

  get 'api_search_streams', to: 'streams#search'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/builder', to: 'static_pages#quote_builder'
  get '/signin', to: 'sessions#new'
  post '/admin/toggle_social', to: 'admin#toggle_social'
  post '/admin/toggle_ip_voting', to: 'admin#toggle_ip_voting'
  post '/announcements/toggle_expire', to: 'announcements#toggle_expire', as: 'announcements_toggle_expire'
  get '/signup', to: 'users#new'
  delete '/signout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'facebook_sessions#create'
  post 'auth/:provider/callback', to: 'facebook_sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'auth/failure', to: redirect('/')
  get 'facebook/signout', to: 'facebook_sessions#destroy', as: 'facebook_signout'

  # error routing
  get '/404', to: 'errors#error_404'
  get '/422', to: 'errors#error_422'
  get '/500', to: 'errors#error_500'
end