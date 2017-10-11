class MessageController < ApplicationController
 
  def index
    newFrom = params[:newMessageFrom]
    @newMessagesFrom = []
    if newFrom != nil
      newFrom.each do |from|
        @newMessagesFrom.push(Student.find(from))
      end
    end

    @messages = Teacher.find(session[:current_teacher_id]).messages
    @responses = []
    @students = []

    @messages.each do |message|
      if @students.include? message.student
      else
        @students.push(message.student)
      end
    end
      
    Rails.logger.debug(@students.inspect)
  end

  def show

    @newMessagesFrom = params[:newMessagesFrom]
    Rails.logger.debug('.................')
    Rails.logger.debug(@newMessagesFrom)
    Rails.logger.debug('.................')

    @all =[]
    @student = Student.find(params[:id])
    @teacher = Teacher.find(session[:current_teacher_id])
    @messages = @student.messages

    @messages.each do |mess|
      mess.responded = true;
      mess.save!
      # Rails.logger.debug(mess.inspect)
    end

    @messages.each do |mess|
      Rails.logger.debug(mess.inspect)
    end

    @teacher = Teacher.find(session[:current_teacher_id])
    @responses = @teacher.responses

    @all.concat(@messages)
    @all.concat(@responses)

    @lla = @all.sort_by {|a| a.created_at}
    @all = @lla.reverse! 
  end

  def new
    @message = Message.new
    @msg = params[:msg]
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create   
    @message = Message.new(message_param)
    if @message.save
      redirect_to :action => 'index' 
    else
      redirect_to :action => 'new', :msg => 'some feilds have not been filled out fully'
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(message_param)
      redirect_to :action => 'show', :id => @message
    else
      render :action => 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
      redirect_to url_for(:controller => :message, :action => :index)
  end
end
