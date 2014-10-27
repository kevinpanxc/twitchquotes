Twitchquotes::Application.routes.draw do
  # resources :users
  resources :quotes do
    get 'search', on: :collection
    get 'marked', on: :collection
    get 'show_marked_quote', on: :member
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :streams, only: [:index, :show]
  resources :announcements, only: [:create, :update, :edit]
  resources :likes, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy]
  resources :random, only: [:index, :show]
  resources :users, only: [:new, :create, :show]

  root to: 'quotes#index'

  get 'api_search_streams', to: 'streams#search'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/builder', to: 'static_pages#quote_builder'
  get '/signin', to: 'sessions#new'
  get '/admin', to: 'users#admin'
  post '/admin/toggle_social', to: 'users#toggle_social'
  get '/signup', to: 'users#new'
  delete '/signout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'facebook_sessions#create'
  post 'auth/:provider/callback', to: 'facebook_sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'auth/failure', to: redirect('/')
  get 'facebook/signout', to: 'facebook_sessions#destroy', as: 'facebook_signout'
end