require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create :user }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.subject).to eq "アカウントの有効化"
    end
  end
end
