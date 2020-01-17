Rails.application.routes.draw do
  root to: 'items#index'
  
  devise_for :users, skip: :all

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'destroy', to: 'devise/sessions#destroy'
  end

  resources :signup ,only: [:index,:create] do
    collection do
      get 'registration'                               
      post 'registration',  to: 'signup#profile_validation' 
      get 'sms_authentication' 
      post 'sms_authentication',  to: 'signup#sms_validation'
      # get 'sms_confirmation'
      # post 'sms_confirmation', to: 'signup#sms_check' 
      get 'address' 
      post 'address', to: 'signup#address_validation' 
      get 'card' 
      get 'done' 
    end
  end  


  resources :users do 
    collection do
      get 'logout'
      get 'profile'
      get 'certification'
      get 'card_registration'
      get 'card_information'
      get 'mypage'
    end
  end

  get 'users/identification(/:id)', to: 'users#identification', as: :user_identification
  resources :items do
    collection do
      get 'category'
    end
    member do
      post 'update_status'
      delete 'destroy_image'
      get 'buy'
      post 'pay'
    end
  end

  get 'items/confirm(/:id)', to: 'items#confirm', as: :items_confirm
  resources :cards


  resources :brands, only: [:index]
  resources :categorys, only: [:index]
end 

  