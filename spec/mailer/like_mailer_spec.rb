require "rails_helper"

RSpec.describe LikeMailer, type: :mailer do
  describe "liked_review" do
    let(:user) { create :user }
    let(:review) { create(:review, user: user) }
    let(:like) { create(:like, review: review, user: user) }
    let(:mail) { LikeMailer.liked_review(user, review) }

    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.to).to eq [review.user.email]
      expect(mail.subject).to eq "感想がナイスされました"
    end

    it "renders the body" do
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match user.name
    end
  end
end
