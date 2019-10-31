require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

if Rails.env.production?
  CarrierWave.configure do |config|
    config.cache_storage = :fog
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["S3_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
      region: "ap-northeast-1",
    }
    config.fog_directory = "game-share-first-bucket"
  end
end
