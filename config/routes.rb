Rails.application.routes.draw do
  root to: "home#index"
  get "login"  => "sessions#new", :as => :login
  get "logout" => "sessions#destroy", :as => :logout
  get "/auth/:provider/callback" => "sessions#social"
  get "/auth/failure" => "sessions#failure"
  resource :sessions

  get "signup" => "users#new", :as => :signup
  get "users/password" => "users#password", :as => :password
  put "users/change_password" => "users#change_password", :as => :change_password
  resources :users

  resources :dojos do
    get "aconteceram" => :happened, as: :happened, on: :collection

    member do
      put "participar" => :participate, as: :participate
      put "desistir"   => :quit,        as: :quit
      get "copiado"    => :copied,      as: :copied
    end

    resources :retrospectives, except: [:index]
  end
end
