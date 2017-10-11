class Message < ApplicationRecord

  belongs_to :teacher
  belongs_to :student


  validates_presence_of :message
  validates_presence_of :student_id
  validates_presence_of :teacher_id

end
