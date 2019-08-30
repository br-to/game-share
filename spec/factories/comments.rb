FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentences(number: 1) }
    user
    review
  end
end
