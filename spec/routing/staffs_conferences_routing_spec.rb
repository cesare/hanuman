require 'rails_helper'

RSpec.describe 'routing to staffs/conferences', type: :routing do
  specify do
    expect(get: '/staff/conferences/123').to route_to(
      controller: 'staffs/conferences',
      action: 'show',
      id: '123'
    )
  end

  specify do
    expect(get: '/staff/conferences/123/edit').to route_to(
      controller: 'staffs/conferences',
      action: 'edit',
      id: '123'
    )
  end

  specify do
    expect(put: '/staff/conferences/123').to route_to(
      controller: 'staffs/conferences',
      action: 'update',
      id: '123'
    )
  end
end
