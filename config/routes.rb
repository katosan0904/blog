Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "blog#index"
  resources :blog, only: [:index, :show, :new, :create, :destroy, :edit, :update] 
    resources :users, only: [:show]
end
