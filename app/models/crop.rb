class Crop < ApplicationRecord
  belongs_to :institute
  has_many :tutorials, dependent: :destroy

  mount_uploader :image, ImageUploader

  TUTORIAL_TYPES = ["Soil", "Planting", "Watering", "Harvesting", "Pests", "Other"]

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :image
  validates_presence_of :institute_id
end
