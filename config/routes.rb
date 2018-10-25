Rails.application.routes.draw do
  root to: 'home#index'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

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
  get '/support/frameworks', to: 'support#frameworks'
end
