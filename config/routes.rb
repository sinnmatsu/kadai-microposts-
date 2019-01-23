Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
      get :favouser
    end
 
  end
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  #フォローを作成するか削除するかのみ
  resources :favos, only: [:create, :destroy]
end
