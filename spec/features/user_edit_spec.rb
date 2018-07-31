require 'rails_helper'

RSpec.feature "User", type: :feature do
  context 'edit user' do
    before(:each) do
      @user = create(:user)
      visit '/login'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'napoleon99'
      click_button 'Log in'
      click_link 'Account'
      click_link 'Edit Profile'
    end

    scenario 'is successful' do
      fill_in 'Name', with: 'napoleon99'
      fill_in 'Password', with: 'napoleon99'
      fill_in 'Password confirmation', with: 'napoleon99'
      click_button 'Update User'
      expect(page).to have_content 'User was updated'
    end

    scenario 'is not successful because of blank password' do
      click_button 'Update User'
      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end
  end

  context 'edit user with check for authorization' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:other_user)
    end

    scenario 'is not successful because user not logged in' do
      visit edit_user_path(@other_user)
      expect(page).to have_content 'Please log in'
    end

    scenario 'is successful after redirect when was logged out' do
      visit edit_user_path(@other_user)
      fill_in 'Email', with: 'alexander@example.com'
      fill_in 'Password', with: 'alexander100'
      click_button 'Log in'
      expect(page).to have_content 'Edit your profile'
    end

    scenario 'is successful after redirect when was logged in as user' do
      visit '/login'
      fill_in 'Email', with: 'napoleon@example.com'
      fill_in 'Password', with: 'napoleon99'
      click_button 'Log in'
      visit edit_user_path(@other_user)
      fill_in 'Email', with: 'alexander@example.com'
      fill_in 'Password', with: 'alexander100'
      click_button 'Log in'
      expect(page).to have_content 'Edit your profile'
    end
  end
end
