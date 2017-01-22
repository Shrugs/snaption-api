Rails.application.routes.draw do

  root 'home#index'

  resource :user
end
