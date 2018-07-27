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
  it do
    expect(get: '/login').to route_to(controller: 'sessions',
                                                  action: 'new')
  end
  it do
    expect(post: '/login').to route_to(controller: 'sessions',
                                                  action: 'create')
  end
  it do
    expect(delete: '/logout').to route_to(controller: 'sessions',
                                                  action: 'destroy')
  end
end
