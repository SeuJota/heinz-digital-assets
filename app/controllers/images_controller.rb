class ImagesController < ApplicationController
	before_action :set_image, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  def index
    @images = Image.all
  end

	def new
		@image = Image.new
	end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to images_path, notice: 'Image was successfully created.'
     else
       render action: 'new'
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end
  def image_params
    params.require(:image).permit(:avatar, :name)
  end
end