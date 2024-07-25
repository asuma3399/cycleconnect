Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts, only: :index

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
end
