class TeacherController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'application'

  def home
    @current_teacher = Teacher.find(session[:current_teacher_id])
    messages = @current_teacher.messages
    @newMessage = false
    @newMessageFrom = []
    messages.each do |m|
      if m.responded == false
        @newMessage = true;
        @newMessageFrom.push(m.student)
      end
    end
  end

  def list
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(session[:current_teacher_id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def teacher_params
    params.require(:teachers).permit(:name, :password, :email, :phone_number)
  end

  def edit
    @teacher = Teacher.find(session[:current_teacher_id])
  end

  def update
    teacher = Teacher.find(session[:current_teacher_id])
    if teacher.update_attributes!(teacher_param)
      redirect_to :action => 'home'
    else
      redirect_to :action => 'edit'
    end
  end

  def teacher_param
    params.require(:teacher).permit( :name, :password, :email, :phone_number, :image)
  end

  def delete
    Teacher.find(session[:current_teacher_id]).destroy
    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
    redirect_to :action => 'list'
  end

  def crops
    teacher = Teacher.find(session[:current_teacher_id])
    institute_id = teacher.institute_id
    redirect_to url_for(:controller => 'crops', :action => 'index', :institute_id => institute_id)
  end



end
