class Institute < ApplicationRecord
	has_one :teacher
	has_many :crops
	has_many :students

  validates_presence_of :institute_name
  validates_presence_of :teacher_admin_id

end
