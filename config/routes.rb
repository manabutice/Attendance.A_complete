Rails.application.routes.draw do
    root 'static_pages#top'
    get '/signup', to: 'users#new'

    get    '/login', to: 'sessions#new'
    post   '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/attendance/index',to:'users#attendance_index'
    
    resources :users do
      member do
        get 'edit_basic_info'
        patch 'update_basic_info'
        patch 'update_index'
        
      end
    resources :attendances, only: :update
  end
end
