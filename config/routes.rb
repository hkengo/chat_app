Rails.application.routes.draw do
  
  root 'rooms#index'
  resources :home, only: [:index, :show]
  resources :rooms
  resources :friends, only: :index

  devise_for :users
  devise_scope :user do
    get 'users/:id', to: 'devise/registrations#show', as: 'users'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
