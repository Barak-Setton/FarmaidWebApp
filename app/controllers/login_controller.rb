require 'mail'

class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def login
    @message = params[:message]
  end

  def logout
    session[:current_teacher_id] = ''
    redirect_to :action => 'login'
  end

  def check_login

    @current_teacher = Teacher.find_by(name: params[:login_info][:name])

    if @current_teacher.blank?
      redirect_to :action => 'login', message: 'user name does not exist'
    elsif @current_teacher[:password] == params[:login_info][:password]
      session[:current_teacher_id] = @current_teacher.id
      session[:institute_id] = @current_teacher.institute.id

      redirect_to url_for(:controller => 'teacher', :action => 'home')
    else
      redirect_to :action => 'login', message: 'access denied'
    end
  end

  def signup
    @institutes = Institute.all
    @message = params[:message]
  end

  def send_signup
    @message = params[:message]

    name = params[:signup_info][:name]
    password = params[:signup_info][:password]
    email = params[:signup_info][:email]
    phone_number = params[:signup_info][:phone_number]
    
    if params[:signup_info][:farm_name] == ""

      admin = Institute.find(params[:signup_info][:institute_id]).teacher
      send_to = admin.email
      email_subject = 'teacher wants to join your institute'

      email = "USER_NAME: " + name.to_s + "\n" + 
        "PASSWORD: "+ password.to_s + "\n" + 
        "EMAIL: " + email.to_s + "\n" + 
        "PHONE NUMBER: " + phone_number.to_s + "\n"

      send_email(send_to, email_subject, email)
    else
      institute_name = params[:signup_info][:farm_name]
      send_to = 'setton.b@gmail.com'
      email_subject = 'new Teacher signing up with a farm'

      email = "USER_NAME: " + name.to_s + "\n" + 
        "PASSWORD: "+ password.to_s + "\n" + 
        "EMAIL: " + email.to_s + "\n" + 
        "PHONE NUMBER: " + phone_number.to_s + "\n" + 
        "FARM NAME: " + institute_name.to_s

      send_email(send_to, email_subject, email)
    end
  end

  def send_email (send_to, email_subject, email)
    Mail.defaults do
      delivery_method :smtp, { 
        :address => 'smtp.gmail.com',
        :port => 587,
        :user_name => 'farmaid.uct@gmail.com',
        :password => 'uctaidfarm',
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    end

    @mail = Mail.new do 
      from    'farmaid.uct@gmail.com'
      to      send_to
      subject email_subject
    end

    @mail[:body] = email

    if @mail.deliver!
      redirect_to :action => 'login', :message => 'You will be emailed your login details once your request has been approved' 
    else
      redirect_to :action => 'singup', :message => 'request was not send, please fill out the form again and resubmitt' 
    end

  end

end
