require "rails_helper"

describe "ナイス機能", type: :system do
  describe "感想・レビューをナイスする" do
    let(:user) { create :user }
    let(:review) { create(:review, user: user) }
    let(:mail) { LikeMailer.liked_review(user, review) }
    before do
      activate user
      login user
      visit review_path(review)
      click_link I18n.t("link.register_like")
    end

    it "ナイス成功" do
      expect(page).to have_content I18n.t("link.delete_like")
      expect(page).to have_content I18n.t("message.likes_count", count: 1)
    end

    it "メール送信成功" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  describe "感想・レビューのナイスを取り消す" do
    before do
      user = create(:user)
      review = create(:review, user: user)
      create(:like, user: user, review: review)
      activate user
      login user
      visit review_path(review)
    end

    it "ナイス取り消しに成功" do
      click_link I18n.t("link.delete_like")
      expect(page).to have_content I18n.t("link.register_like")
      expect(page).to have_content I18n.t("message.likes_count", count: 0)
    end
  end
end
