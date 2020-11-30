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
      # 勤怠変更申請
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'  
      # １ヶ月承認
      get 'attendances/edit_month_approval'
      patch 'attendances/update_month_approval'
      # 確認のshowページ
      get 'verifacation'
      # 勤怠ログ
      get 'attendances/log'
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
        # 勤怠変更お知らせモーダル
      get 'edit_one_month_notice'
      patch 'update_one_month_notice'
        #１ヶ月承認モーダル
      get 'edit_month_approval_notice'
      patch 'update_month_approval_notice'
      end
    end 
  end

end
