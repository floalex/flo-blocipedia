Rails.application.routes.draw do
  
  devise_for :users
    resources :users, only: [:update, :show]
 
  resources :wikis
 
  resources :subscriptions, only: [:new, :create]
  
  get 'about' => 'welcome#about'
  get 'downgrade' => 'subscriptions#downgrade'

  root to: 'welcome#index'
end
