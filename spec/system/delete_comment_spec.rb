require "rails_helper"

describe "コメント削除", type: :system do
  let(:user) { create :user }
  let(:review) { create :review }

  before do
    create(:comment, user: user, review: review)
  end

  it "コメント削除成功" do
    activate user
    login user
    visit review_path(review)
    click_link I18n.t("link.delete_comment")
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t("flash.comment_destroy_success")
  end
end
