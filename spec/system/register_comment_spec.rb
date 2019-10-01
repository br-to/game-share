require "rails_helper"

describe "コメントの登録", type: :system do
  let(:user) { create :user }
  let(:review) { create(:review, user: user) }
  let(:mail) { CommentMailer.commented_review(user, review, comment) }
  before do
    activate user
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

    it "メール送信成功" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  context "不正なcontentを入力した場合" do
    let(:content) { nil }

    it "コメント登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end
