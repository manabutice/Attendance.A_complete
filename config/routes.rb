Rails.application.routes.draw do
    root 'static_pages#top'
    get '/signup', to: 'users#new'

    get    '/login', to: 'sessions#new'
    post   '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    
    resources :users do
      member do
        get 'attendances/edit_one_month'
      end
    resources :attendances, only: :update
  end
end
