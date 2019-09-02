require "rails_helper"

describe "コメント削除" do
  let(:user) { create :user }
  let(:review) { create :review }
  before do
    create(:comment, user: user, review: review)
    login user
  end

  it "コメント削除成功" do
    visit review_path(review)
    click_link I18n.t("link.delete_comment")
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t("flash.comment_destroy_success")
  end
end