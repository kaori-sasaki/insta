Rails.application.routes.draw do
  get 'sessions/new'

  get '/', to:'tops#index'
  resources :blogs do
    collection do
      post :confirm
   end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  get '/sessions',to:'sessions#new'
end