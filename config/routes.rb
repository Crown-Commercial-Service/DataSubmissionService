Rails.application.routes.draw do
  root to: 'home#index'
  resources :uploads, only: %i[create]

  resources :tasks, only: %i[index show] do
    member do
      get 'upload', to: 'uploads#completed_return'
      get 'upload/review', to: 'uploads#review'
      get 'complete', to: 'tasks#complete'
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/style_guide', to: 'styleguide#index'
end
