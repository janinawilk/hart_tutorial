require 'rails_helper'
require 'user_helper'

RSpec.configure do |c|
  c.include UserHelper
end

RSpec.feature "User", type: :feature do
  context 'logging' do
    before(:each) do
      @user = create(:user)
      visit '/login'
      fill_in 'Email', with: 'napoleon@example.com'
    end

    scenario 'in is successful' do
      fill_in 'Password', with: 'napoleon99'
      click_button 'Log in'
      expect(page).to have_content @user.email
      expect(page).to have_link 'Log out'
      expect(page).to have_link 'Profile'
      expect(page).not_to have_link 'Log in'
      # expect(is_logged_in?).to be_truthy
      # expect(cookies['remember_token'].empty?).to be_truthy
    end

    scenario 'in is successful with remember_me checked' do
      fill_in 'Password', with: 'napoleon99'
      check 'Remember me'
      click_button 'Log in'
    end

    scenario 'in is not successful' do
      click_button 'Log in'
      expect(page).to have_content 'Wrong email or password'
    end

    scenario 'in is not successful and checks for flash message' do
      click_button 'Log in'
      visit root_path
      expect(page).not_to have_content 'Wrong email or password'
    end

    scenario 'out is successful' do
      fill_in 'Password', with: 'napoleon99'
      click_button 'Log in'
      click_link 'Account'
      click_link 'Log out'
      expect(page).not_to have_link 'Log out'
      expect(page).to have_link 'Log in'
    end
  end
end
