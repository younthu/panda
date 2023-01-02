class Panda::PhotoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # fix orientation issue: https://stackoverflow.com/questions/44895719/images-uploaded-from-mobile-have-incorrect-orientation
  process :fix_exif_rotation

  def fix_exif_rotation
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  version :thumb_nail do
    process resize_to_fit: [2400, 2400]

  end


  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # def asset_host
  #   return "FIXME"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # 把长宽信息写进文件名里，供客户端布局用
  # def filename
  #   g = ::MiniMagick::Image.open(file.file)[:dimensions]
  #   if self.parent_version&.file
  #     g = ::MiniMagick::Image.open(self.parent_version.file.file)[:dimensions]
  #   end
  #   "#{original_filename}.wxh.#{g[0]}x#{g[1]}.#{file.extension}" if original_filename
  # end
end
