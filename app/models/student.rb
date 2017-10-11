class Student < ApplicationRecord
	belongs_to :institute
	has_many :messages
end
