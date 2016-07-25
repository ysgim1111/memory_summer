CarrierWave.configure do |config|                       # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJ6R243BYITJS4VOA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-1'
  }
  config.fog_directory  = 'gosomi'                          # required
end
