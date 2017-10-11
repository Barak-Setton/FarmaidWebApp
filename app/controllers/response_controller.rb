class ResponseController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def show
    @response = Response.find(params[:id])
  end

  def new
    @response = Response.new
    @msg = params[:msg]
  end

  def edit
    @response = Response.find(params[:id])
  end

  def create   
    @response = Response.new(response_param)

    if @response.save
      redirect_to url_for(:controller => :message, :action => :show , :id => params[:student_id])
    else
      redirect_to :action => 'new', :msg => 'some feilds have not been filled out fully'
    end
  end

  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(response_param)
      redirect_to url_for(:controller => :message, :action => :index)
    else
    end
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    redirect_to :action => 'index' 
  end

  def response_param
     params.require(:response).permit(:response).merge(:teacher_id => session[:current_teacher_id], :student_id => params[:student_id])
  end
end
