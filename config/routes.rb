Rails.application.routes.draw do
  resources :tasks, only: [:index]

  get '/auth/:provider/callback', to: 'sessions#create'
end
