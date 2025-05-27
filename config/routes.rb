Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'

    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'

    get 'users/favorites' => 'users#favorites', as: 'user_favorites'

    get 'users/:username' => 'users#show', as: 'user'

    resources :users, only: [] do
      resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :posts do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end

    get 'users/:username/toys' => 'toys#index', as: 'user_toys'
    resources :toys, only:[:new, :create, :show, :edit, :update, :destroy]
    get 'toys/by_user/:user_id', to: 'toys#by_user'

    get 'search' => 'searches#search'

  end

  devise_for :admin, skip: [:registrations, :passwords],  controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    root to: 'homes#top'

    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end

    resources :users, only: [:index, :show, :edit, :update]
    
    get 'search' => 'searches#search'
  end

end
