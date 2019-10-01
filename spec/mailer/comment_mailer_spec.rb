require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }
  let(:comment) { create(:comment, review: review, user: user) }
  describe "commented_review" do
    let(:mail) { CommentMailer.commented_review(user) }

    it "renders the headers" do
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.subject).to eq "感想にコメントがつきました"
    end
  end
end
