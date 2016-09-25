CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ID"],
    aws_secret_access_key: ENV["AWS_SECRET"],
    region:                ENV["AWS_REGION"],
  }
  config.fog_directory  =  ENV["S3_BUCKET"]
end