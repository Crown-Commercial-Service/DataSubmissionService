Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: %i[index] do
    resources :submissions, only: %i[new create] do
      resource :review, only: %i[new create]
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/style_guide', to: 'styleguide#index'
end
