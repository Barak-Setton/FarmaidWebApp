class Tutorial < ApplicationRecord
  belongs_to :crop
  has_many :images, dependent: :destroy

  TUTORIAL_TYPES = ["Soil", "Planting", "Watering", "Harvisting", "Pest Control", "Other"]
end
