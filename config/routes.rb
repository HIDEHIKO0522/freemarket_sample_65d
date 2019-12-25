Rails.application.routes.draw do
  devise_for :users,skip: :all
  # , controllers: {
  #   registrations:      'users/registrations',
  #   sessions:           'users/sessions'
  #   # omniauth_callbacks: 'users/omniauth_callbacks'
  # }
 #ファイル名は未定（12/24 白岩）
  devise_scope :user do
    delete 'destroy' => 'devise/sessions#destroy',as: :current_user_destroy
  end

  root to: 'home#index'
  # get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :signup ,only: [:index,:create] do
    collection do
      get 'registration'                               
      post 'registration' => 'signup#profile_validation' 
      get 'sms_authentication' 
      post 'sms_authentication' => 'signup#sms_post' 
      get 'sms_confirmation' 
      post 'sms_confirmation' => 'signup#sms_check'
      get 'address' 
      post 'address' => 'signup#address_validation' 
      get 'card' 
      get 'done' 
    end
  end  



  resources :users do
    collection do
      get 'logout'
    end
  end
  get 'users/identification(/:id)', to: 'users#identification', as: :user_identification
  resources :items
  get 'items/confirm(/:id)', to: 'items#confirm', as: :items_confirm
  resources :cards


end 
