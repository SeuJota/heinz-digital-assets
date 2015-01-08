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
		render "images/public/show" unless session[:public] == "admin"
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

  def edit
    @category = @image.category
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to category_image_path(id: @image, category_id: @image.category), notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@category = @image.category
    @image.destroy
    respond_to do |format|
      format.html { redirect_to @category, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
		@image = Image.find(params[:id])
		style = params[:quality].to_sym
		ending = "_hd"
		ending = "_md" if style == :medium
		ending = "_sd" if style == :small

		send_file(Paperclip.io_adapters.for(@image.avatar(style)).path,
			:type => @image.avatar_content_type,
			:disposition => "attachment",
			:filename => @image.name+ending)
	end

  def export
    @images = Image.all.order(:code)
    respond_to do |format|
      format.xls 
    end
  end

  def import
    Image.import(params[:file])
    redirect_to images_control_url, notice: "Produtos importados corretamente."
  end

  def control
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end
  def image_params
    params.require(:image).permit(:avatar, :name, :category_id, :code, :upc, :dim_unit, :weight_unit, :box_unit, :dim_box, :weight_box, :box_pallet, :description)
  end
end
