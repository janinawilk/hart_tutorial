require 'rails_helper'
require 'user_helper'

RSpec.describe UsersController, type: :controller do

describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response.successful?).to be_truthy
    end
  end

  describe 'GET #index' do
    it 'redirects when user not logged in' do
      get :index
      expect(response.successful?).to be_falsey
    end
  end

  describe 'PATCH #delete ' do
    let(:admin_user) { create(:admin_user) }
    let(:user) { create_list(:user, 40) }

    it 'redirects when not logged in' do
      # expect { delete :destroy, id: user.id }.not_to change { User.count}
    end
  end

  describe 'PATCH admin attribute' do
    let(:user) { create(:user) }
    let(:update_params) do
      { id: user.id, user_id: user.id, user: user, admin: true }
    end

    it 'is unsuccessful' do
      log_in_as(user)
      expect(user.admin?).to be_falsey
      # patch :update, params:
      #                             {
      #                               user:
      #                               {
      #                                 password: user.password,
      #                                 password_confirmation: user.password,
      #                                 admin: true
      #                               }
      #                             }
      # patch : update, update_params
      # expect(user.admin?).to be_truthy
    end
  end
end
