require "rails_helper"

describe "感想・レビュー削除" do
  let(:user) { create :user }
  let(:game) { create :game }
  before do
    @review = create(:review, game: game, user: user)
    login user
  end

  it "感想・レビュー削除成功" do
    visit review_path(@review)
    click_link I18n.t("link.delete_review")
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t("flash.review_destroy_success")
  end
end
