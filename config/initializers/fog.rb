# Checkpoint #44 - Uploading Images
#
# Create a file named fog.rb in the config/initializers/ directory. Add the
# following code.
#
# Initializer names are arbitrary; all initializers are run on server launch. We
# could have called our Fog initializer something else, but that would have been
# confusing.
CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:               'AWS',
        aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
    }
    
    config.fog_directory = ENV['AWS_BUCKET']
    config.fog_public = true
end

# Ref:
# https://support.cloud.engineyard.com/entries/20996881-Use-CarrierWave-and-Optionally-Fog-to-Upload-and-Store-Files#update3
# http://stackoverflow.com/questions/7946819/carrierwave-and-amazon-s3