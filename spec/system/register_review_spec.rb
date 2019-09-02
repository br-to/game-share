require "rails_helper"

describe "感想・レビューの登録" do
  let(:user) { create :user }
  let(:game) { create(:game, user: user) }
  before do
    login user
    visit new_game_review_path(game)
    fill_in "review[content]", with: content
    click_button I18n.t("title.register")
  end

  context "正しい値を入力した場合" do
    let(:content) { Faker::Lorem.sentence }

    it "感想・レビュー登録成功" do
      expect(page).to have_content I18n.t("flash.review_registration_success")
      expect(page).to have_content content
    end
  end

  context "不正なcontentを入力した場合" do
    let(:content) { nil }

    it "感想・レビュー登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end
