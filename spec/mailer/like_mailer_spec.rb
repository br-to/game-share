require "rails_helper"

RSpec.describe LikeMailer, type: :mailer do
  describe "liked_review" do
    let(:user) { create :user }
    let(:review) { create(:review, user: user) }
    let(:like) { create(:like, review: review, user: user) }
    let(:mail) { LikeMailer.liked_review(user, review) }

    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.subject).to eq "感想がナイスされました"
    end
  end
end
