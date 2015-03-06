class CategoriesController < ApplicationController
	before_action :set_category, only: [:show, :edit, :update, :destroy, :search]
	before_action :authenticate_user!
	before_action :is_admin?, only: [:edit, :update, :new, :destroy]
	caches_page :show, :new

	def root_page
	end

	def index
		if params[:category] == "Quero"
			@categories = Category.find_by_name("Quero").children
			@title = "quero"
		elsif params[:category] == "Heinz"
			@categories = Category.find_by_name("Heinz").children
			@title = "heinz"
		else
			@categories = Category.all.order("updated_at DESC")
			@title = "todas"
		end
		render "categories/public/index" unless session[:public] == "admin"
	end

	def show
		@images = @category.images
		unless session[:public] == "admin"
			if @category.is_leaf?
				render "categories/public/shutter"
			else
				render "categories/public/show"
			end
		end
	end

	def new
		@category = Category.new
		@parent = params[:id]
		@name = Category.find(params[:id]).name unless @parent.blank?
	end

	def edit
		@parent = params[:parent]
	end

	def create
		@category = Category.new(category_params)
		@category.height = @category.parent.height + 1 if @category.parent

		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: 'Category was successfully created.' }
				format.json { render :show, status: :created, location: @category }
			else
				format.html { render :new }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @category.update(category_params)
				format.html { redirect_to @category, notice: 'Category was successfully updated.' }
				format.json { render :show, status: :ok, location: @category }
			else
				format.html { render :edit }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@category.destroy
		respond_to do |format|
			format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	def search
		@heinzimages = Image.search(params[:query], Category.first.children_id)
		@queroimages = Image.search(params[:query], Category.second.children_id)
		@both = false
		if @heinzimages.count > 0 && @queroimages.count > 0
			@both = true
			render "categories/public/shutter"
		elsif @heinzimages.count > 0 && @queroimages.count == 0
			@category = Category.first
			@images = @heinzimages
			render "categories/public/shutter"
		elsif @heinzimages.count == 0 && @queroimages.count > 0
			@category = Category.second
			@images = @queroimages
			render "categories/public/shutter"
		else
			@errorh = "Nenhum resultado encontrado."
			@queryh = params[:query]
			render "categories/public/index"
		end
		

		# @images = Image.search(params[:query], @category.children_id)
		# @image = Image.find(@images[0].id) unless @images[0].nil?
		# redirect_to category_image_path(category_id: @image.category, id: @image) if @images.size == 1
		# render "categories/public/shutter" if @images.size > 1
		# if @images.size == 0
		# 	if @category.id == Category.find_by_name("Heinz").id
		# 		@errorh = "Nenhum resultado encontrado."
		# 		@queryh = params[:query]
		# 	else
		# 		@errorq = "Nenhum resultado encontrado."
		# 		@queryq = params[:query]
		# 	end
		# 	render "categories/public/index"
		# end
	end

	private

	def is_admin?
		redirect_to root_path unless current_user.admin?
	end

	def set_category
		@category = Category.friendly.find(params[:id])
	end

	def category_params
		params.require(:category).permit(:name, :parent_id, :height)
	end
end
