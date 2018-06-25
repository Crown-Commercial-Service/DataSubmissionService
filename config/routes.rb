Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: [:index]
  resources :uploads, only: %i[create]

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/style_guide', to: 'styleguide#index'
end
