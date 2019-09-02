require "rails_helper"

describe "ゲームタイトル編集" do
  before do
    user = create(:user)
    game = create(:game, user: user)

    login user
    visit edit_game_path(game)
    fill_in "game[title]", with: title
    click_button I18n.t("title.edit")
  end

  context "正しい値を入力した場合" do
    let(:title) { Faker::Game.title }

    it "編集成功" do
      expect(page).to have_content I18n.t("flash.game_update_success")
      expect(page).to have_content title
    end
  end

  context "不正なtitleを入力した場合" do
    let(:title) { nil }

    it "編集失敗" do
      expect(page).to have_content I18n.t("flash.update_failed")
    end
  end
end
