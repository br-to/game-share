require "rails_helper"

describe "ゲームタイトル登録", type: :system do
  let(:user) { create :user }

  before do
    activate user
    login user
    visit new_game_path
    fill_in "game[title]", with: title
    attach_file "game[picture]", "#{Rails.root}/spec/fixtures/game.png"
    click_button I18n.t("title.register")
  end

  context "正しい値を入力した場合" do
    let(:title) { Faker::Game.title }

    it "登録成功" do
      expect(page).to have_current_path games_path
      expect(page).to have_selector("img[src$='game.png']")
      expect(page).to have_content I18n.t("flash.game_registration_success")
    end
  end

  context "不正なtitleを値を入力した場合" do
    let(:title) { nil }

    it "登録失敗" do
      expect(page).to have_content I18n.t("flash.registration_failed")
    end
  end
end
