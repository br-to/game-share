require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { create :user }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.to).to eq [user.email]
      expect(mail.subject).to eq "アカウントの有効化"
    end

    it "renders the body" do
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match user.name
    end
  end
end
