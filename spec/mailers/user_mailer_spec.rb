require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body with activation link" do
      expect(mail.body.encoded).to include(edit_account_activation_path(user.activation_token, email: user.email))
    end
  end

  describe "password_reset" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.password_reset(user) }
    before(:each) do
    user.create_reset_digest
    user.send_password_reset_email
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(edit_password_reset_url(user.reset_token, email: user.email))
    end
  end
end
