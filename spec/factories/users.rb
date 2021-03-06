FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/user.png")) }
    activated { false }
  end
end
