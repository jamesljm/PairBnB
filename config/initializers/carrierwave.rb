CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV["aws_Access_Key_ID"],                        # required
      aws_secret_access_key: ENV['aws_Secret_Access_Key'],                        # required
      region:                'ap-southeast-1',                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'pairbnbnext'                                   # THIS WILL BE MY AWS S3 BUCKET
    # config.fog_public     = false                                                 # optional, defaults to true
    # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end