Rails.application.routes.draw do
  resources :conferences, only: %i(index show) do
    scope module: 'conferences' do
      resources :proposals, only: %i(show new create)
    end
  end

  get '/auth', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get '/', to: 'home#show', as: :root
end
