require 'rails_helper'

RSpec.describe 'routing to conferences/proposals', type: :routing do
  specify do
    expect(get: '/conferences/123/proposals/987').to route_to(
      controller: 'conferences/proposals',
      action: 'show',
      conference_id: '123',
      id: '987'
    )
  end

  specify do
    expect(get: '/conferences/123/proposals/new').to route_to(
      controller: 'conferences/proposals',
      action: 'new',
      conference_id: '123',
    )
  end

  specify do
    expect(post: '/conferences/123/proposals').to route_to(
      controller: 'conferences/proposals',
      action: 'create',
      conference_id: '123',
    )
  end

  specify do
    expect(get: '/conferences/123/proposals/987/edit').to route_to(
      controller: 'conferences/proposals',
      action: 'edit',
      conference_id: '123',
      id: '987'
    )
  end

  specify do
    expect(put: '/conferences/123/proposals/987').to route_to(
      controller: 'conferences/proposals',
      action: 'update',
      conference_id: '123',
      id: '987'
    )
  end
end
