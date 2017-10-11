class CropsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @institute = Institute.find(session[:institute_id])
    @crops = @institute.crops
  end

  def show
    @crop = Crop.find(params[:id])
  end

  def new
    @crop = Crop.new
    @msg = params[:msg]
  end

  def edit
    @crop = Crop.find(params[:id])
  end

  def create
    @crop = Crop.new(crop_param)

    # check if crop saves
    if @crop.save
      # text file stuff

      institute = Institute.find(session[:institute_id])
      
      description = params[:crop][:description]
      imageName = @crop[:image].to_s[0..-5]
		
	description = description.gsub!(/\n/,'<br>')
      # creating the path to store the crop info
      path = "uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+params[:crop][:name].to_s+"/thumbnail_"+imageName.to_s+".txt"
      
      # getting name of file
      filename = Rails.root.join("public/"+path)

      # writing description to the file
      File.open(filename, "wb") do |f|
        f.write(description)
      end
      redirect_to :action => 'index' 
    else
      redirect_to :action => 'new', :msg => 'some feilds have not been filled out fully'
    end
  end

  def update
    @crop = Crop.find(params[:id])
    institute = Institute.find(session[:institute_id])

    # creating a new path of changed crop info
    old_path = "public/uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+@crop.name.to_s
    new_path = "public/uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+params[:crop][:name].to_s
    
    # checjing if old path is different to new path
    if old_path != new_path
      # removing old text description
      FileUtils.rm_rf(old_path +"/thumbnail_"+@crop.name.to_s+".txt" )
      # moving the directory
      FileUtils.mv old_path, new_path
    end

    # updating the info on the crop
    if @crop.update_attributes(crop_param)
      # updating text file stuff
      description = params[:crop][:description]
      imageName = @crop[:image].to_s[0..-5]
      description.gsub!(/\n/,'<br>')
      #creating text file path
      path = "public/uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+params[:crop][:name].to_s+"/thumbnail_"+imageName+".txt"

      # writing description to the file
      File.open(path, "wb") do |f|
        f.write(description)
      end
      redirect_to :action => 'show', :id => @crop
    else
      render :action => 'edit'
    end
  end

  def delete
    # check if crop exists
    if Crop.exists?(params[:id])
      # finding and deleteing the crop
      crop = Crop.find(params[:id])
      crop.destroy
      # removing the text file
      FileUtils.rm_rf("public/uploads/farm_"+Institute.find(session[:institute_id]).institute_name.to_s+"/crops/crop_"+crop.name)
    end
    redirect_to :action => 'index' 
  end

  def update_tutorial
    @image = Image.find(params[:id])
    if @image.update_attributes(image_param)

      # text file stuff
      crop = @image.tutorial.crop
      tut = @image.tutorial
      institute = Institute.find(session[:institute_id])
      # description = image_param[:description]
      path = "uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+crop.name.to_s+"/tutorial_"+tut.tutorial_type.to_s+"/thumbnail_"+tut.tutorial_type.to_s+".txt"
      
      filename = Rails.root.join("public/"+path)


      images = tut.images

      description = ""

      #ording the images to the order they need to be in for the tutorial
      images = images.sort_by {|img| img.image_order}

      images.each do |img|
        order = img.image_order
        description += "Step "+order.to_s+": <br>"+img.description+"<br><br>"
      end

      # writing description to the file
      File.open(filename, "wb") do |f|
        f.write(description)
      end
      redirect_back(fallback_location: root_path)
    else
    end
  end

  # adding a tutorial to the database
  def add_tutorial
    crop_id = params[:tutorial][:crop_id]

    # finding ou if an existing 
    # tutorial type was chosen or 
    # if they put their own one in
    if(params[:tutorial][:type_name] == "")
      tutorial_type = params[:tutorial][:tutorial_type]
    else
      tutorial_type = params[:tutorial][:type_name]
    end

    # creating the tutorial
    if new_tutorial=Tutorial.create(:tutorial_type => tutorial_type, :crop_id => crop_id)
      for i in 1..10
        if params[:tutorial]['image_'+i.to_s]

          new_params  = image_params(i).values[0]

          image_order = i
          description = params[:tutorial]['text_'+i.to_s]
          tutorial_id = new_tutorial[:id]

          @image = Image.create(:name=>new_params, :image_order=>image_order, :description=>description, :tutorial_id=>tutorial_id)
          
          # text file stuff
          crop = Crop.find(crop_id)
          tut = Tutorial.find(tutorial_id)
          institute = Institute.find(session[:institute_id])
          path = "uploads/farm_"+institute.institute_name.to_s+"/crops/crop_"+crop.name.to_s+"/tutorial_"+tut.tutorial_type.to_s+"/tutorial_"+tut.tutorial_type.to_s+".txt"
          
          filename = Rails.root.join("public/"+path)

          File.open(filename, "a+") do |f|
            f.write("Step "+i.to_s+": <br>"+description+"<br><br>")
          end
        end
      end
    end
    redirect_to :action => 'show', :id => crop_id
  end

  private

    def image_params(index)
      params.require(:tutorial).permit('image_'+index.to_s)
    end
    def image_param
      params.require(:image).permit(:name, :description)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @crop = Crop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crop_params
      params.require(:crops).permit(:name, :description, :image)
    end
    
    def crop_param
      params.require(:crop).permit(:name, :description, :image).merge(institute_id: session[:institute_id])
    end


end
