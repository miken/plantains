Rails.application.routes.draw do
  resources :events
  get 'welcome/index'
  root 'welcome#index'
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
