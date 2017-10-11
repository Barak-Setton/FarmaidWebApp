class AndroidController < ApplicationController
  # protect_from_forgery with: :null_session
  #1 = incorrect login details
  #2 = no new files to download
  #3 = no new messages to downlaod
  #4 = Message not saved onto database

  skip_before_action :verify_authenticity_token


 # POST function to check for user login
  def login

    # send paramaters of body
    email = params[:email]
    password = params[:password]

    # find student of username and password
    student = Student.find_by_email(email)

    if student.password == password 
      render plain: "Login Success:farm_"+ student.institute.institute_name
    else
      render plain: "Error:1"
    end
  end


  # send back lissting of files to download (since last update)
  def update
  
    # find student with email (to see if they are registered)
    if student = Student.find_by_email(params[:email])

      # get last update time of student
      last_updated = student.last_file_update

      # find institute and crops of the institute 
      institute = student.institute
      crops = institute.crops
      
      url_list = ""

      # go through each crop of institute to compare last update of crop with last update of student
      crops.each do |crop|
        if crop.updated_at > last_updated
          # creating url to be sent back to android app (for the GET request)
          text_url = "/uploads/farm_"+institute.institute_name+"/crops/crop_"+crop.name+"/thumbnail_"+crop.name.to_s+".txt"
          url_list = url_list + crop.image.thumbnail.to_s + "<br>" + text_url.to_s + "<br>"
        end
        # looking through tutorials and see last updated images 
        tutorials = crop.tutorials
        tutorials.each do |tut|
          images = tut.images
          images.each do |image|
            if image.updated_at > last_updated
              # creating url for android app (for the GET request)
              text_url = "/uploads/farm_"+institute.institute_name+"/crops/crop_"+crop.name+"/tutorial_"+tut.tutorial_type.to_s+"/tutorial_"+tut.tutorial_type.to_s+".txt"
              url_list += image.name.to_s + "<br>" + text_url + "<br>"
            end
          end
        end
      end
        if url_list == nil
          render plain: "Error:2"
        else
          # update last update time of student
          student.last_file_update = Time.now()
          student.save!
          render plain: url_list
        end
    else
      render plain: "Error:1"
    end 
  end


 # send a list of messages (since last update)
  def update_messages
    # body contains email of student
    body = "#{request.body.read}"
    # find student related to the email
    if student = Student.find_by_email(body)
      # find teachers response to be sent back
      teacher_id = student.institute.teacher_admin_id
      teacher = Teacher.find(teacher_id)
      responses = teacher.responses

      sendBack = ""

      # look though each response to find resence once
      responses.each do |response|
        if student.last_message_update < response.updated_at
          sendBack += "Message:"+response.response.to_s+"<br/>"+"Time:"+response.updated_at.to_s+"<br/>"+"From:super"+"<br/>"
        end
      end

      Rails.logger.debug(sendBack)
      if sendBack == nil
        render plain: "Error:3"
      else
        # update last updated time of students messages
        student.last_message_update = Time.now()
        student.save!
        render plain: sendBack
      end
    else
      render plain: "Error:1"
    end
  end

  # function for students to send message to teacher
  def send_message
    # body contains students email and message sent by student
    body = "#{request.body.read}"
    words_arr = body.split("<>")
    email = words_arr[0]
    message = words_arr[1]

    if student = Student.find_by_email(email)
      s_id = student.id
      t_id = student.institute.teacher_admin_id

      m = Message.new(:message => message, :student_id => s_id, :teacher_id => t_id, :responded => false)
      # saving message to database and sneds the message make as conformation
      if m.save
        render plain: "Message:" + m.message.to_s + "<br/>" + "Time:"+ m.created_at.to_s + "<br/>" + "From:user" + "<br/>"
      else
        render plain: "Error:4"
      end
    else
      render plain: "Error:1"
    end
  end

  # function to send text file
  def get_file
    body = "#{request.body.read}"
    Rails.logger.debug(body)
    send_file "public/"+body
  end

end
