require "rails_helper"

describe "コメントの登録" do
  let(:user) { create :user }
  let(:review) { create(:review, user: user) }
  before do
    login user
    visit review_path(review)
    fill_in "comment[content]", with: content
    click_button I18n.t("title.comment")
  end

  context "正しい値を入力した場合" do
    let(:content) { Faker::Lorem.sentence }

    it "コメント登録成功" do
      expect(page).to have_content I18n.t("flash.comment_registration_success")
      expect(page).to have_content content
    end
  end

  context "不正なcontentを入力した場合" do
    let(:content) { nil }

    it "コメント登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end
