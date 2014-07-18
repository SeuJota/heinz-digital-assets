class ImagesController < ApplicationController
	before_action :set_image, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  def index
    @category = Category.friendly.find(params[:category_id])
    @images = @category.images
  end

	def new
		@image = Image.new
		@category = Category.friendly.find(params[:category_id])
		@name = Category.friendly.find(@category.id).name unless @category.nil?
	end

	def show
		 @category = Category.friendly.find(params[:category_id])
	end

  def create
  	@category = Category.friendly.find(params[:category_id])
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image.category, notice: 'Image was successfully created.'
     else
       render action: 'new'
    end
  end

  def destroy
  	category = @image.category
    @image.destroy
    respond_to do |format|
      format.html { redirect_to category, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
	@image = Image.find(params[:id])

	send_file(Paperclip.io_adapters.for(@image.avatar).path, 
		:type => @image.avatar_content_type, 
		:disposition => "attachment", 
		:filename => @image.name+"_hd")
end
def download_sd
	@image = Image.find(params[:id])

	send_file(Paperclip.io_adapters.for(@image.avatar.url(:medium)).path, 
		:type => @image.avatar_content_type, 
		:disposition => "attachment", 
		:filename => @image.name+"_sd")
end

  private
    def set_image
      @image = Image.find(params[:id])
    end
  def image_params
    params.require(:image).permit(:avatar, :name, :category_id)
  end
end