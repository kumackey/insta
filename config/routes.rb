Rails.application.routes.draw do
  root to: 'posts#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :posts, shallow: true do
    resources :comments
  end
  resources :likes,         only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
