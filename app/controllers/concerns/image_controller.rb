class ImageController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /crops/new
  def new
    @image = Image.new
  end
  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    Image.find(params[:id]).destroy
    redirect_to :action => 'index' 
  end
end
