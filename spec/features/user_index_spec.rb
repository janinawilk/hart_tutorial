require 'rails_helper'

RSpec.feature "User", type: :feature do
  context 'index' do
    before(:each) do
      create_list(:user, 40)
      @admin_user = create(:admin_user)
      visit '/login'
      fill_in 'Email', with: @admin_user.email
      fill_in 'Password', with: @admin_user.password
      click_button 'Log in'
      click_link 'Users'
    end

    scenario 'shows pagination' do
      expect(page).to have_content 'Next'
    end

    scenario 'enables admin to delete users' do
      first(:link, 'delete').click
      expect(page).to have_content 'User deleted'
    end
  end
end
