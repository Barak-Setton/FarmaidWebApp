class ImageUploader < CarrierWave::Uploader::Base
  permissions 0666
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if "#{model.class.to_s.underscore}" == "image"
      # tut
      "uploads/farm_#{model.tutorial.crop.institute.institute_name}/#{model.tutorial.crop.class.to_s.underscore}s/#{model.tutorial.crop.class.to_s.underscore}_#{model.tutorial.crop.name}/#{model.tutorial.class.to_s.underscore}_#{model.tutorial.tutorial_type}"
    else
      # crops / teachers
      "uploads/farm_#{model.institute.institute_name}/#{model.class.to_s.underscore}s/#{model.class.to_s.underscore}_#{model.name}"
    end
    

  end

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
  #   process scale: [100, 100]
  # end

  # Create different versions of your uploaded files:
  version :full do
    process resize_to_fit: [300, 300]
    process :convert => 'png'
  end

  # Create different versions of your uploaded files:
  version :thumbnail do
    process resize_to_fit: [150, 150]
    process :convert => 'png'
  end

  # version :android do
  #   process resize_to_fit: [150, 150]
  # end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
	if "#{model.class.to_s.underscore}" == "image"
		"#{model.tutorial.tutorial_type.to_s}"+"#{model.image_order.to_s}"+".png" if original_filename
	else
		"#{model.name.to_s}"+".png" if original_filename
	end
  end

end
