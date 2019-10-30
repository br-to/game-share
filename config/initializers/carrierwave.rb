CarrierWave.configure do |config|
  config.cache_storage = :fog
  config.fog_provider = "fog/aws"
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: "ap-northeast-1",
  }

  config.fog_directory = "game-share-first-bucket"
end
