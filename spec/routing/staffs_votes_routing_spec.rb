require 'rails_helper'

RSpec.describe 'routing to staff/conferences/votes', type: :routing do
  specify do
    expect(post: '/staff/conferences/123/votes').to route_to(
      controller: 'staffs/votes',
      action: 'create',
      conference_id: '123'
    )
  end

  specify do
    expect(delete: '/staff/conferences/123/votes/987').to route_to(
      controller: 'staffs/votes',
      action: 'destroy',
      conference_id: '123',
      id: '987'
    )
  end
end
