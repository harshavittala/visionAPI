Rails.application.routes.draw do
	get 'users/index'
	root 'users#index'
  resources :users do
  	get :avatar, on: :member
  end	
  get '/uploads/grid/user/avatar/:id/:filename' => 'users#avatar'
end
