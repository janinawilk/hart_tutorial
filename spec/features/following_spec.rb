require 'rails_helper'

RSpec.feature "Follwoing", type: :feature do
  context 'on user show page' do
    before(:each) do
      other_user = create(:other_user)
      user = create(:user)
      visit '/login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Users'
      first(:link, 'show').click
    end

    scenario 'follow' do
      expect { click_button 'Follow' }.to change(Relationship, :count).by(1)
    end

    scenario 'unfollow' do
      click_button 'Follow'
      expect { click_button 'Unfollow' }.to change(Relationship, :count).by(-1)
    end
  end
end
