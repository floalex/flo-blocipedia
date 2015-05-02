Rails.application.routes.draw do
  
  devise_for :users
    resources :users, only: [:update, :show, :index]
 
  resources :wikis do
    resources :collaborators
  end

  resources :subscriptions, only: [:new, :create]
  
  
  get 'about' => 'welcome#about'
  get 'downgrade' => 'subscriptions#downgrade'

  root to: 'welcome#index'
end
