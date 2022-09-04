Rails.application.routes.draw do
  root to: 'public/homes#top'
  #customers
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
   namespace :public do
     post 'orders/confirm' => 'orders#confirm'
    resources :customers, only: [:show, :edit, :update, :quit]
    
    resources :orders, only: [:new, :index, :show, :create, :confirm] do
      collection do
        get :complete
      end
    end
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    
    resources :items, only: [:index, :show]
    get 'homes/top'
    get 'homes/about'
  end
  
  # admin
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
