Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"

  resources :services, only: [:index, :show, :new, :create] do
    resources :bookings, except: [:destroy, :index, :edit, :update]
  end
  resources :bookings, only: [:destroy, :index, :edit, :update]
end
