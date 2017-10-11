class Image < ApplicationRecord
  belongs_to :tutorial
  # has_many :audios

  # for i in 1..10
  #   mount_uploader 'image_'+i.to_s, ImageUploader
  # end

  mount_uploader :name, ImageUploader

end
