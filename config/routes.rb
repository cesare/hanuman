Rails.application.routes.draw do
  resources :conferences, only: %i(index show) do
    scope module: 'conferences' do
      resources :proposals, only: %i(index show new create)
    end
  end

  namespace :staff, module: 'staffs' do
    resources :conferences, only: %i(show edit update)
  end

  get '/auth', to: 'sessions#new'
  get '/auth/:provider', to: -> (_env) { [404, {}, ['Not Found']] }, as: 'auth_provider'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get '/', to: 'home#show', as: :root
end
