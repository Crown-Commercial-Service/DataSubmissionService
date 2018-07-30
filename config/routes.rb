Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: %i[index] do
    resources :submissions, only: %i[new create show] do
      resource :complete, only: :create, controller: 'submission_completion'

      resource :review, only: %i[new create]
      get '/review/ingest_status_polling/', to: 'reviews#ingest_status_polling'
      get '/review/calculate_status_polling/', to: 'reviews#calculate_status_polling'
      get '/review/processing/', to: 'reviews#processing'
    end

    resource :no_business, only: %i[new create]
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/style_guide', to: 'styleguide#index'
  get '/tools', to: 'tools#index'
end
