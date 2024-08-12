Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

  resources :chat_rooms, only: [:index, :new, :create, :destroy, :show] do
    resources :messages, only: [:create]
    resources :events, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      member do
        post 'participate'
        delete 'unparticipate'
      end
    end
  end
  resources :profiles, only: [:show, :edit, :update]
end