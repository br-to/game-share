require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do
  describe "commented_review" do
    let(:user) { create(:user) }
    let(:review) { create(:review, user: user) }
    let(:comment) { create(:comment, review: review, user: user) }
    let(:mail) { CommentMailer.commented_review(user, review, comment) }
    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.to).to eq [review.user.email]
      expect(mail.subject).to eq "感想にコメントがつきました"
    end

    it "renders the body" do
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match user.name
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match comment.content
    end
  end
end
