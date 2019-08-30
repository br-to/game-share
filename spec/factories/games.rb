FactoryBot.define do
  factory :game do
    title { Faker::Game.title }
    user
  end
end
