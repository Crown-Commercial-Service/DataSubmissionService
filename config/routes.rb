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

    resource :no_business, only: %i[new create]
  end

  resources :submissions, only: [] do
    collection do
      match 'bulk_new', via: %i[get post]
      post :bulk_confirm
      post :bulk_create
      post :customer_effort_score
    end
  end

  resources :urns, only: %i[index]

  resource :template, only: %i[show]

  resources :agreements, only: %i[index]

  resources :release_notes, only: %i[index]

  resource :user_detail, only: %i[show edit update] do
    get :edit_email
    patch :update_email
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match '/auth/failure', to: 'errors#auth_failure', via: %i[get post]
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/verify_email', to: 'sessions#verify_email', as: :verify_email
  get '/style_guide', to: 'styleguide#index'
  get '/support', to: 'support#index'
  get '/support/frameworks', to: 'support#frameworks'
  get '/cookie-settings', to: 'home#cookie_settings'
  get '/cookie-policy', to: 'home#cookie_policy'
  get '/accessibility', to: 'accessibility#index'
  get '/check', to: 'check#index'
  get '/email/verification/:token', to: 'email_verifications#show', as: :email_verification
  post '/email/verification/resend', to: 'email_verifications#resend_email', as: :resend_email_verification
  post '/email/verification/cancel_pending_email_change', to: 'email_verifications#cancel_pending_email_change',
                                                          as: :cancel_pending_email_change
end
