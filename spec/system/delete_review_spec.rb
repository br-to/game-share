require "rails_helper"

describe "感想・レビュー削除", type: :system do
  let(:user) { create :user }
  let(:game) { create :game }
  describe "ネタバレなしレビュ―削除" do
    let(:review) { create :review, game: game, user: user }

    it "ネタバレなし感想・レビュー削除成功" do
      login user
      visit review_path(review)
      click_link I18n.t("link.delete_review")
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content I18n.t("flash.review_destroy_success")
      expect(page).to have_current_path game_path(game)
    end
  end

  describe "ネタバレありレビュー削除" do
    let(:review) { create :review, is_spoiled: true, game: game, user: user }

    it "ネタバレ削除成功" do
      login user
      visit review_path(review)
      click_link I18n.t("link.delete_review")
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content I18n.t("flash.review_destroy_success")
      expect(page).to have_current_path game_path(game)
    end
  end
end
