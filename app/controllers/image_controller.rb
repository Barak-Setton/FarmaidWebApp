class ImageController < ApplicationController

  # GET /crops/new
  def new
    @crop = Crop.new
    @msg = params[:msg]
  end

  def delete
    Image.find(params[:id]).destroy
  end

end
