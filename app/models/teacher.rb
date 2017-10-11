class Teacher < ApplicationRecord
	belongs_to :institute
	has_many :messages
	has_many :responses

	mount_uploader :image, ImageUploader
	validates_presence_of :name
	validates_presence_of :password
	validates_presence_of :email
	validates_presence_of :phone_number
	validates_presence_of :institute_id
end
