FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    user
    review
  end
end
