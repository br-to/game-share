require "rails_helper"

describe "ゲームタイトル編集", type: :system do
  before do
    create(:user)
    game = create(:game)

    login game.user
    visit edit_game_path(game)
    fill_in "game[title]", with: title
    attach_file "game[game_picture]", "#{Rails.root}/spec/fixtures/game2.png"
    click_button I18n.t("title.edit")
  end

  context "正しい値を入力した場合" do
    let(:title) { Faker::Game.title }

    it "編集成功" do
      expect(page).to have_content I18n.t("flash.game_update_success")
      expect(page).to have_selector("img[src$='game2.png']")
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
