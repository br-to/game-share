require "rails_helper"

describe "ナイス機能", type: :system do
  before do
    user = create(:user)
    review = create(:review, user: user)
    create(:like, user: user, review: review)
    login user
    visit review_path(review)
    click_link I18n.t("link.delete_like")
  end

  describe "感想・レビューをナイスする" do
    it "ナイス成功" do
      click_link I18n.t("link.register_like")
      expect(page).to have_content I18n.t("link.delete_like")
      expect(page).to have_content I18n.t("message.likes_count", count: 1)
    end
  end

  describe "感想・レビューのナイスを取り消す" do
    it "ナイス取り消しに成功" do
      expect(page).to have_content I18n.t("link.register_like")
      expect(page).to have_content I18n.t("message.likes_count", count: 0)
    end
  end
end
