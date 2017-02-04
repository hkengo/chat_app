Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get 'users/:id', to: 'devise/registrations#show', as: 'users'
  end
  
  root 'home#index'
  resources :home, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
