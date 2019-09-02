require "rails_helper"

describe "感想・レビューの登録" do
  let(:user) { create :user }
  let(:game) { create(:game, user: user) }
  before do
    login user
    visit new_game_review_path(game)
    fill_in "review[content]", with: content
    check "review[is_spoiled]"
    click_button I18n.t("title.register")
  end

  context "正しい値を入力した場合" do
    let(:content) { Faker::Lorem.sentence }
    let(:is_spoiled) { true }

    it "ネタバレ登録成功" do
      expect(page).to have_content I18n.t("flash.spoiler_registration_success")
      expect(page).to have_content content
    end
  end

  context "不正なcontentを入力した場合" do
    let(:content) { nil }
    let(:is_spoiled) { true }

    it "ネタバレ登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end