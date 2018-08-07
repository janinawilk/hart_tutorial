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
    let!(:users) { create_list(:user, 40) }

    context 'not logged in' do
      it 'does not delete user' do
        expect { delete :destroy, params: { id: users.first.id } }
          .not_to change { User.count }
      end
    end

    context 'logged in as regular user' do
      it 'does not delete user' do
        session[:user_id] = users.first.id
        expect { delete :destroy, params: { id: users.first.id } }
          .not_to change { User.count }
      end
    end
  end

  describe 'PATCH admin attribute' do
    let(:user) { create(:user) }
    let(:update_params) do
      {
        password: user.password,
        password_confirmation: user.password,
        admin: true
      }
    end


    it 'is unsuccessful' do
      session[:user_id] = user.id
      expect(user.admin?).to be_falsey
      patch :update, params: { id: user.id, user: update_params }
      user.reload
      expect(user.admin?).to be_falsey
    end
  end
end
