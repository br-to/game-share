require "rails_helper"

describe "ゲームタイトル削除" do
  let(:user) { create :user }
  before do
    @game = create(:game, user: user)
    login user
  end

  it "titleの削除成功" do
    visit game_path(@game)
    click_link I18n.t("link.delete_game")
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t("flash.game_destroy_success")
    expect(page).to have_current_path games_path
  end
end
