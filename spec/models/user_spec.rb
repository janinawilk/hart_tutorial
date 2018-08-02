require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user)}

  context 'general validations' do
    it 'is valid' do
      expect(user.valid?).to be_truthy
    end
    it 'is invalid when name not present' do
      user.name = ''
      expect(user.valid?).to be_falsey
    end
    it 'is invalid when email not present' do
      user.email = ''
      expect(user.valid?).to be_falsey
    end
    it 'is invalid when name longer than 50 chars' do
      user.name = 'a'* 51
      expect(user.valid?).to be_falsey
    end
    it 'is invalid when email longer than 255 chars' do
      user.email = 'a'* 256
      expect(user.valid?).to be_falsey
    end
    it 'is invalid when email not unique' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user.valid?).to be_falsey
    end
  end

  context 'downcase email stored in db' do
    it '\s email is stored in db as downcased' do
      user.email = 'uSeR@example.com'
      user.save
      expect(user.email.downcase).to eql(user.email)
    end
  end

  context 'password validations' do
    it 'is invalid when password not present' do
      user.password = user.password_confirmation = ''
      expect(user.valid?).to be_falsey
    end
    it 'is invalid when password shorter than 6 char' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user.valid?).to be_falsey
    end
  end

  context 'valid email validations' do
    valid_addresses = %w[user@example.com USER@foo.pl A_b-g@foo.bar.pl fiRSt.petr99@bar.jj foo+bar@pop.org]
    valid_addresses.each do |valid_address|
      it "is valid with #{valid_address}" do
        user.email = valid_address
        expect(user.valid?).to be_truthy
      end
    end
  end

  context 'invalid email validations' do
    invalid_addresses = %w[user@example,com USERfoo.pl A_b-g@foo-pl fiRSt.petr99@ @pop.org]
    invalid_addresses.each do |invalid_address|
      it "is invalid with #{invalid_address}" do
        user.email = invalid_address
        expect(user.valid?).to be_falsey
      end
    end
  end

  context 'checks for authentication when user logged out in other browser' do
    it 'is not authenticated when digest is nil' do
      expect(user.authenticated?(:remember, '')).to be_falsey
    end
  end
end
