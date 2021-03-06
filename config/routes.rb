Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'messages/loader' => 'messages#loader'
  get 'home/letrock' => 'home#letrock'

  resources :profiles, only:[:index,:show,:edit,:update]
  resources :messages
  resources :orders
  resources :locations, only:[:index,:new,:create,:edit,:update]
  resources :books, only:[:index,:new,:create,:edit,:update]
  resources :inventories
  root to:'home#index'
end
