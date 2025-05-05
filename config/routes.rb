Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  scope module: :public do
    root to: 'homes#top'

    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/:username' => 'users#show', as: 'user'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'

    get 'users/favorites' => 'users#favorites', as: 'user_favorites'

    resources :posts
  end

  devise_for :admin, skip: [:registrations, :passwords],  controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
  end

end
