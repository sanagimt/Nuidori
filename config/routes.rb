Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  root to: 'homes#top'

end
