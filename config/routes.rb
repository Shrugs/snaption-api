Rails.application.routes.draw do

  root 'home#index'

  resources :users
  resources :games do
    member do
      put 'join', to: 'games#join'
    end
  end
end
