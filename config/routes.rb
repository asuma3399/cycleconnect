Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  resources :chat_rooms, only: [:index, :new, :create, :destroy, :show] do
    resources :messages, only: [:create]
    resources :events, only: [:index, :show, :new, :create] do
      member do
        post 'participate'
        delete 'unparticipate'
      end
    end
  end
  resource :profile, only: [:show, :edit, :update]
end