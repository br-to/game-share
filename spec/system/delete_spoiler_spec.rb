require "rails_helper"

describe "ネタバレ削除", type: :system do
  let(:user) { create :user }
  let(:game) { create :game }
  let(:review) { create :review, is_spoiled: true, game: game, user: user }
  before do
    login user
  end

  it "ネタバレ削除成功" do
    visit review_path(review)
    click_link I18n.t("link.delete_review")
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t("flash.review_destroy_success")
  end
end
