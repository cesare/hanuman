require 'rails_helper'

RSpec.describe 'routing to staff/conferences/proposals', type: :routing do
  specify do
    expect(get: '/staff/conferences/123/proposals').to route_to(
      controller: 'staffs/proposals',
      action: 'index',
      conference_id: '123'
    )
  end
end
