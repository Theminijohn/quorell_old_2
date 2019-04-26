Rails.application.routes.draw do
  resources :topics
  devise_for :users
  root 'pages#home'
end
