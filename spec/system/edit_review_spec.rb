require "rails_helper"

describe "感想・レビュー編集" do
  before do
    user = create(:user)
    game = create(:game, user: user)
    review = create(:review, game: game)
    login user
    visit edit_review_path(review)
    fill_in "review[content]", with: content
    click_button I18n.t("title.edit")
  end

  context "正しい値を入力した場合" do
    let(:content) { Faker::Lorem.sentence }

    it "感想・レビュー編集成功" do
      expect(page).to have_content I18n.t("flash.review_update_success")
      expect(page).to have_content content
    end
  end

  context "不正なcontentを入力した場合" do
    let(:content) { nil }

    it "感想・レビュー編集失敗" do
      expect(page).to have_content I18n.t("flash.update_failed")
    end
  end
end
