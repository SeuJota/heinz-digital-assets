class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:show, :edit, :update, :destroy, :approved, :disapproved, :set_admin, :unset_admin]
	before_action :is_admin?

	def users_admin
		if params[:approved] == "false"
			@users = User.disapproved.order("updated_at DESC")
		elsif params[:admin] == "true"
			@users = User.admin
		else
			@users = User.all.order("updated_at DESC")
		end
		render "users/index"
	end

	def show
	end

	def edit
	end

	def set_admin
		@user.update(admin: true)
		redirect_to users_path(admin: true)
	end

	def unset_admin
		@user.update(admin: false)
		redirect_to users_path()
	end

	def approved
		@user.update(approved: true)
		redirect_to users_path()
	end

	def disapproved
		@user.update(approved: false)
		redirect_to users_path(approved: false)
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to users_path, notice: 'User was successfully updated.' }
				format.json { render :show, status: :ok, location: @user }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def is_admin?
		redirect_to root_path unless current_user.admin?
	end
	
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		registration_params = [:name, :email, :password, :password_confirmation, :approved, :admin]
		params.require(:user).permit(registration_params)
	end
end
