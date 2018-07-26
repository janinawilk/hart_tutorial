require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  it 'check for Help link' do
    visit '/home'
    click_link('Help')
    expect(current_path).to eql('/help')
  end
  it 'check for About link' do
    visit '/home'
    click_link('About')
    expect(current_path).to eql('/about')
  end
  it 'check for Home link' do
    visit '/home'
    click_link('Home')
    expect(current_path).to eql('/')
  end
  it 'check for \'Sign up\' button' do
    visit '/home'
    click_link('Sign up now!')
    expect(current_path).to eql('/signup')
  end
end
