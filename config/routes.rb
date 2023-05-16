Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "services#home"
  resources :services, only: [:index, :show, :new, :create] do
    resources :bookings, except: :destroy
  end
  resources :bookings, only: :destroy

end
