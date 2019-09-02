require "rails_helper"

describe "ゲーム一覧" do
  let(:user) { create :user }
  before do
    game1 = create(:game, user: user, created_at: 2)
    game2 = create(:game, user: user, created_at: 3)
    game3 = create(:game, user: user, created_at: 1)
    @games = [game3, game1, game2]
  end

  it "created_at順に並ぶと成功" do
    login user
    visit games_path
    @games.each do |game| 
      expect(page).to have_content game.title 
    end
  end
end
