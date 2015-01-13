Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.providers.facebook.key, Settings.providers.facebook.secret
  provider :github, Settings.providers.github.key, Settings.providers.github.secret, scope: 'user:email'
end
