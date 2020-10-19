Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Home and about page
  root 'pages#home' # pages_controller.rb home method and pages/home.html.erb view
  # get 'about', to: 'pages#about' # pages_controller.rb about method and pages/about.html.erb view

  # Articles table - grants restful routes
  resources :articles

  # Categories table - grants restful routes
  resources :categories

  # Users table - grants restful routes
  #   (except for new since that is handled by /signup url)
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # Login & Session routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
