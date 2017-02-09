Rails.application.routes.draw do
  
  root 'rooms#index'
  resources :home, only: [:index, :show]
  resources :rooms
  resources :friends, only: [:index, :new] do
    patch :follow
    patch :unfollow
    patch :block
    patch :unblock
  end
  namespace :friends do
    patch :search
  end
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'users/:id', to: 'users/registrations#show', as: 'users'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
