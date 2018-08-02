require 'rails_helper'

RSpec.feature "User", type: :feature do
  context 'create new user' do
    before(:each) do
      visit '/signup'
      fill_in 'Email', with: 'napoleon@example.com'
      fill_in 'Password', with: 'napoleon99'
      fill_in 'Password confirmation', with: 'napoleon99'
    end

    scenario 'is successful' do
      fill_in 'Name', with: 'napoleon'
      click_button 'Create User'
      expect(page).to have_content 'Please check your email to activate your account'
      user = User.find_by(email: 'napoleon@example.com')
    end

    scenario 'is successful and checks for user count' do
      fill_in 'Name', with: 'napoleon'
      expect {
        click_button 'Create User'
      }.to change(User, :count).by(1)
    end

    scenario 'is not successful' do
      click_button 'Create User'
      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end
