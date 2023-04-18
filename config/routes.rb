Rails.application.routes.draw do
  get 'challenges', to: 'challenges#index'
  post 'challenges', to: 'challenges#run'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
