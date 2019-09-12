FactoryBot.define do
  factory :game do
    title { Faker::Game.title }
    game_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/game.png")) }
    user
  end
end
