Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  scope module: :public do
    root to: 'homes#top'

    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'

    get 'users/favorites' => 'users#favorites', as: 'user_favorites'

    get 'users/:username' => 'users#show', as: 'user'

    resources :posts do
      resources :comments, only: [:create, :destroy]
    end

    get 'search' => 'searches#search'

  end

  devise_for :admin, skip: [:registrations, :passwords],  controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    root to: 'homes#top'

    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

end
