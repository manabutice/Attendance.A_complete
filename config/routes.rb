Rails.application.routes.draw do

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
      # 残業申請確認モーダル
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month' 
      # 確認のshowページ
      get 'verifacation'
    end
    collection do
      get 'working'
    end
    resources :attendances, only: [:update] do
      member do
        # 残業申請モーダル
        get 'edit_overtime_request'
        patch 'update_overtime_request'
        # 残業申請お知らせモーダル
        get 'edit_overtime_notice'
        patch 'update_overtime_notice'
        # 残業申請確認モーダル
        get 'show_overtime_verifacation'
      end
    end 
  end

end
