Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: %i[index] do
    resources :submissions, only: %i[new create show] do
      resource :complete, only: :create, controller: 'submission_completion'
    end

    resource :no_business, only: %i[new create]
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/style_guide', to: 'styleguide#index'
  get '/urns', to: 'urns#index'
  get '/support', to: 'support#index'
end
