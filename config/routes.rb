Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get '/', to: 'home#show', as: :root
end
