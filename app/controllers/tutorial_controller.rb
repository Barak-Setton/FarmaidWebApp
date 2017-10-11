class TutorialController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @tutorials = Tutorial.all
  end

  # GET /crops/1
  # GET /crops/1.json
  def show
    @tutorial = Tutorial.find(params[:id])
  end

  # GET /crops/new
  def new
    @tutorial = Tutorial.new
    @msg = params[:msg]
  end

  # GET /crops/1/edit
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  # POST /crops
  # POST /crops.json
  def create   
    @tutorial = Tutorial.new(tutorial_param)
    if @tutorial.save
      redirect_to :action => 'index' 
    else
      redirect_to :action => 'new', :msg => 'some feilds have not been filled out fully'
    end
  end

  # PATCH/PUT /crops/1
  # PATCH/PUT /crops/1.json
  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.update_attributes(tutorial_param)
      redirect_to :action => 'show', :id => @tutorial
    else
      render :action => 'edit'
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def delete
    Tutorial.find(params[:id]).destroy
    redirect_to :action => 'index' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @tutorial = Tutorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutorial_params
      params.require(:tutorials).permit()
    end
    
    def tutorial_param
      params.require(:tutorial).permit()
    end
end
