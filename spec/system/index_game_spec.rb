require "rails_helper"

describe "ゲーム一覧", type: :system do
  let(:user) { create :user }

  before do
    create(:game, title: "pokemon", user: user)
    create(:game, title: "mario", user: user)
    create(:game, title: "zeruda", user: user)
  end

  it "作成順に並ぶと成功" do
    activate user
    login user
    visit games_path
    game_titles = all(".game-title").map(&:text)
    expect(game_titles).to eq ["zeruda", "mario", "pokemon"]
  end
end
