Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  resources :users
end