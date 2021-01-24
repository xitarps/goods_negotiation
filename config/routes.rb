Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :products
  resources :chats, only: %i[ index new show ]
  resources :messages, only: %i[ create ]
end
