require 'rails_helper'

RSpec.feature "User", type: :feature do
  context 'profile' do
    before(:each) do
      user = create(:user_with_microposts)
      visit '/login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Account'
      click_link 'Profile'
    end

    scenario 'shows pagination' do
      expect(page).to have_content 'Next'
    end
  end
end
