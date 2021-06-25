Rails.application.routes.draw do
  root to: 'home#index'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  resources :tasks, only: %i[index show] do
    collection do
      get :history
    end
    member do
      get :correct
      get :cancel_correction_confirmation
      patch :cancel_correction
    end
    resources :submissions, only: %i[new create show] do
      member do
        get :download
      end

      resource :complete, only: :create, controller: 'submission_completion'
    end
    resource :template, only: %i[show]

    resource :no_business, only: %i[new create]
  end

  resource :urns, only: :show do
    member do
      get :download
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'errors#auth_failure'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  post '/terminate_user/:auth_id', to: 'sessions#terminate'
  get '/style_guide', to: 'styleguide#index'
  get '/support', to: 'support#index'
  get '/support/frameworks', to: 'support#frameworks'

  get '/accessibility', to: 'accessibility#index'
end
