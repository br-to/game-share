FactoryBot.define do
  factory :review do
    content { Faker::Lorem.sentences(number: 1) }
    game
    user
    is_spoiled { false }
  end
end
