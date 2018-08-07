require 'rails_helper'

RSpec.describe @micropost, type: :model do
  before(:each) do
    @micropost = create(:micropost)
  end

  context 'validation' do

    it 'is valid' do
      expect(@micropost.valid?).to be_truthy
    end

    it 'is not valid when no user' do
      @micropost.user_id = nil
      expect(@micropost.valid?).to be_falsey
    end

    it 'is not valid when no content' do
      @micropost.content = nil
      expect(@micropost.valid?).to be_falsey
    end

    it 'is not valid when content longer than 140 chars' do
      @micropost.content = 'a' * 141
      expect(@micropost.valid?).to be_falsey
    end
  end

  context 'order' do
    let(:recent) { create(:recent) }

    it 'correct when most recent first' do
      expect(recent).to eq(Micropost.first)
    end
  end
end
