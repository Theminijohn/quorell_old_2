Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  resources :topics

	namespace :api do
		namespace :v1 do
			resources :questions, only: :create
		end
	end
end
