require 'rails_helper'

RSpec.describe 'routing to staff/conferences/proposals', type: :routing do
  specify do
    expect(get: '/staff/conferences/123/proposals').to route_to(
      controller: 'staffs/proposals',
      action: 'index',
      conference_id: '123'
    )
  end

  specify do
    expect(get: '/staff/conferences/123/proposals/987').to route_to(
      controller: 'staffs/proposals',
      action: 'show',
      conference_id: '123',
      id: '987'
    )
  end
end
