require 'rails_helper'

describe 'Routing', type: :routing do
  it { expect(root: 'static_pages', action: 'home') }
  it do
    expect(get: '/home').to route_to(controller: 'static_pages',
                                                 action: 'home')
  end
  it do
    expect(get: '/about').to route_to(controller: 'static_pages',
                                                  action: 'about')
  end
  it do
    expect(get: '/signup').to route_to(controller: 'users',
                                                  action: 'new')
  end
end
