require 'rails_helper'

RSpec.describe 'routing to conferences', type: :routing do
  specify do
    expect(get: '/conferences').to route_to(
      controller: 'conferences',
      action: 'index'
    )
  end

  specify do
    expect(get: '/conferences/123').to route_to(
      controller: 'conferences',
      action: 'show',
      id: '123'
    )
  end
end
