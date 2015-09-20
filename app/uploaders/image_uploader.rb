# Assignment #44 - Uploading Images
#
# Posts should have images as well as users.
#   - Create an 'image_uploader' that will be used to upload images for Posts.
#     Adapt 'avatar_uploader.rb' to get a better understanding of the file
#     structure.
#
# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  
  # Checkpoint #44 - Uploading Images
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick

  # Checkpoint #44 - Uploading Images
  #
  # (Comment out 'storge :file'; remove comment from 'storage: fog')
  #
  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # Checkpoint #44 - Uploading Images
  #
  process :resize_to_fill => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end
  
  # Checkpoint #44 - Uploading Images
  #
  version :tiny do
    process :resize_to_fill => [20, 20]
  end
  
  version :small do
    process :resize_to_fill => [30, 30]
  end
  
  version :profile do
    process :resize_to_fill => [45, 45]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #
  # Checkpoint #44 - Uploading Images
  #
  # (Uncomment the 'extension_white_list' method)
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end