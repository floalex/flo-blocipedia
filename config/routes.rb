Rails.application.routes.draw do
  
  devise_for :users
    resources :users, only: [:update, :show]
 
  resources :wikis
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
