# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'in seed'

institute = Institute.new(institute_name: 'Bfarm')
if institute.save
	puts "institute created"
else
	puts "-- institute"
end

teach = Teacher.new( name: 'barak', password: '1', email: 'barak_setton@hotmail.com', phone_number: '1234567890', institute_id: institute.id)
if	teach.save
	puts "teacher created"
else
	puts "-- teacher"
end


 
# INSERT INTO students VALUES (1, 'robbie', '1', 'robbie@gmail.com', '123456789', ' ', 1, NOW(), NOW(), NOW(), NOW());


robbie = Student.new(name: 'robbie', password: '1', email: 'robbie@gmail.com', phone_number: '0123456789', profile_picture: ' ', institute_id: institute.id, last_file_update: DateTime.now, last_message_update: DateTime.now)
if robbie.save
	puts "student created"
else
	Rails.logger.debug(robbie.errors.full_messages) 
	puts "-- student"
end

message = Message.new(message: 'hello i would like help please', student_id: robbie.id, teacher_id: teach.id)
if message.save
	puts "message creaetd"
else
	puts "-- message"
end


puts 'after seed'
