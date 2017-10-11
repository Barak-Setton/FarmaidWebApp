class InstituteController < ApplicationController  
  skip_before_action :verify_authenticity_token  

  # GET /crops.json
  def index
    @institutes = Institute.all
    @msg = params[:message]
  end

  def show
    @institute = Institute.find(params[:id])
  end

  # GET /crops/new
  def new
    @institute = Institute.new
    # @msg = params[:msg]
  end

  def create  
    @institute = Institute.new(:institute_name => params[:institute][:institute_name], :teacher_admin_id => params[:institute][:teacher_admin_id])

    if @institute.save
      redirect_to :action => 'index', :message => "succesfully added institute"
    else
      redirect_to :action => 'new', :msg => 'some feilds have not been filled out fully'
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    if Institute.exists?(params[:id])
      @institute = Institute.find(params[:id])
      @institute.destroy
    end
    redirect_to :action => 'index' 

        # check if crop exists
    # if Institute.exists?(params[:id])
    #   # finding and deleteing the crop
    #   institute = Institute.find(params[:id])
    #   institute.destroy
    # end 
  end

end