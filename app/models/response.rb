class Response < ApplicationRecord

  validates_presence_of :response
  validates_presence_of :teacher_id
  validates_presence_of :student_id

end
