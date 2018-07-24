require 'rails_helper'

describe 'Routing', type: :routing do
  it { expect(root: 'static_pages', action: 'home') }
  it {
    expect(get: 'static_pages/home').to route_to(controller: 'static_pages',
                                                 action: 'home')
  }
  it {
    expect(get: 'static_pages/about').to route_to(controller: 'static_pages',
                                                 action: 'about')
  }
end
