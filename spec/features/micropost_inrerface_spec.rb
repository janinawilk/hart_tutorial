require 'rails_helper'

RSpec.feature "Micropost", type: :feature do
  context 'interface' do
    before(:all) do
      # create_list(:user, 10)
      # user = User.first
      user = create(:user)
      visit '/login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Home'
    end

    scenario 'creating blank microposts is not successful' do
      fill_in 'Content', with: ''
      click_button 'Create Micropost'
      expect(page).to have_content 'Content can\'t be blank'
    end

    scenario 'creating microposts is successful' do
      fill_in 'Content', with: 'Wazzup'
      click_button 'Create Micropost'
      expect(page).to have_content 'Micropost created'
      expect(page).to have_content "#{Micropost.count} micropost"
    end

    # scenario 'creating microposts is successful' do
    #   click_link 'Users'
    #   click_link 'show'
    #   expect(page).not_to have_content 'delete'
    # end
  end
end
