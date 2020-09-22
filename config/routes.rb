Rails.application.routes.draw do
  get 'bases/new'
  get 'bases/create'
  get 'bases/edit'
  get 'bases/update'
  get 'bases/shoe'
  get 'bases/destroy'
    root 'static_pages#top'
    get '/signup', to: 'users#new'

    get    '/login', to: 'sessions#new'
    post   '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :bases
    resources :users do
      collection { post :import }
      member do
        get 'edit_basic_info'
        patch 'update_basic_info'
        patch 'update_index'
        get 'attendances/edit_one_month'
        patch 'attendances/update_one_month'
      end
      collection do
        get 'working'
      end
    resources :attendances, only: :update
  end
end
