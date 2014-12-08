require 'rails_helper'

RSpec.describe 'routing to sessions', type: :routing do
  specify do
    expect(get: '/auth').to route_to(
      controller: 'sessions',
      action: 'new'
    )
  end

  specify do
    expect(get: '/auth/github/callback').to route_to(
      controller: 'sessions',
      action: 'create',
      provider: 'github'
    )
  end

  specify do
    expect(get: '/signout').to route_to(
      controller: 'sessions',
      action: 'destroy'
    )
  end
end
