Rails.application.routes.draw do

  root 'home#index'

  resources :users
  resources :games do
    member do
      put 'join', to: 'games#join'
      put 'play_caption', to: 'games#play_caption'
      put 'play_snap', to: 'games#play_snap'
    end
  end
end
