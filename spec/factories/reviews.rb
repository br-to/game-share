FactoryBot.define do
  factory :review do
    content { Faker::Lorem.sentence }
    game
    user
    is_spoiled { false }
  end
end
