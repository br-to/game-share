require "rails_helper"

describe "ゲーム一覧", type: :system do
  let(:user) { create :user }
  before do
    game1 = create(:game, title: "pokemon", user: user)
    game2 = create(:game, title: "mario", user: user)
    game3 = create(:game, title: "zeruda", user: user)
  end

  it "作成順に並ぶと成功" do
    login user
    visit games_path
    within ".games" do
      game_titles = all(".game-title").map(&:text)
      expect(game_titles).to eq ["zeruda", "mario", "pokemon"]
    end
  end
end
