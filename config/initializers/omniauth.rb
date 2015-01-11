Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.providers.github.key, Settings.providers.github.secret, scope: 'user:email'
end
