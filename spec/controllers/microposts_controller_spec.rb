require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:user) { create(:user_with_microposts) }

  describe 'POST #create' do
    it 'redirects when user not logged in' do
      post :create, params: {
        micropost: { content: 'Lorem ipsum' }
      }
      expect { post :create, params: {
          micropost: { content: 'Lorem ipsum' }
        } }.not_to change { Micropost.count }
    end

    it 'is successful when user logged in' do
      session[:user_id] = user.id
      expect { post :create, params: {
          micropost: { content: 'Lorem ipsum' }
        } }.to change { Micropost.count }
    end
  end

  describe 'PATCH #delete ' do
    it 'redirects when user not logged in' do
      delete :destroy, params: { id: user.microposts.first.id }
      expect(response.successful?).to be_falsey
    end

    it 'does not delete micropost when user not logged in' do
      user
      expect { delete :destroy, params: { id: user.microposts.first.id } }
        .not_to change { Micropost.count }
    end

    it 'deletes micropost when user logged in' do
      session[:user_id] = user.id
      expect { delete :destroy, params: { id: user.microposts.first.id } }
        .to change { Micropost.count }
    end
  end
end
