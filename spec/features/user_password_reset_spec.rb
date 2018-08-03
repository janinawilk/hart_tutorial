require 'rails_helper'

RSpec.feature "User", type: :feature do
  feature 'password reset' do
    background(:each) do
      @user = create(:user)
      visit '/login'
      click_link 'Forgot password?'
    end

    scenario 'not successul due to outdated link' do
      expect(page).to have_content 'Email'
      fill_in 'Email', with: @user.email
      expect {
        click_button 'Send password reset'
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(page).to have_content 'Email sent with password reset instructions'
      @user.update_attribute(:reset_sent_at, 3.hours.ago)
      open_email(@user.email)
      current_email.click_link 'Reset password'
      expect(page).to have_content 'Password reset has expired'
    end

    scenario 'not successul due to wrong email' do
      fill_in 'Email', with: 'bleble@com.pl'
      expect {
        click_button 'Send password reset'
      }.not_to change(ActionMailer::Base.deliveries, :count)
    end

    scenario 'is successful' do
      expect(page).to have_content 'Email'
      fill_in 'Email', with: @user.email
      expect {
        click_button 'Send password reset'
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
      expect(page).to have_content 'Email sent with password reset instructions'
      open_email(@user.email)
      current_email.click_link 'Reset password'
      fill_in 'Password', with: 'kanadyjka'
      fill_in 'Password confirmation', with: 'kanadyjka'
      click_button 'Change password'
      expect(page).to have_content 'Password has been reset'
    end
  end
end
