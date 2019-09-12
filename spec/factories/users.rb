FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
    user_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/user.png")) }
  end
end
