Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get 'logout'
      get 'profile'
    end
  end
  get 'users/identification(/:id)', to: 'users#identification', as: :user_identification
  resources :items do
    collection do
      get 'category'
    end
  end
  get 'items/confirm(/:id)', to: 'items#confirm', as: :items_confirm
  resources :cards


end 
