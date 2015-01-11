module OmniauthHelpers
  def setup_omniauth(provider:, uid:, name:, email:)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(
      provider: provider.to_s,
      uid: uid,
      info: {
        name: name,
        email: email,
      }
    )
  end
end

RSpec.configure do |config|
  config.include OmniauthHelpers, type: :feature
end
