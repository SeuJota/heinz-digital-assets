class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :configure_devise_permitted_parameters, if: :devise_controller?
	layout :layout_by_resource

protected

	def layout_by_resource
		if devise_controller? && !user_signed_in?
			"devise"
		else
			"application"
		end
	end

	def configure_devise_permitted_parameters
		registration_params = [:name, :email, :password, :password_confirmation, :approved, :admin, :area, :address, :phone, :company]

		if params[:action] == 'update'
			devise_parameter_sanitizer.for(:account_update) {
			|u| u.permit(registration_params << :current_password)
			}
		elsif params[:action] == 'create'
			devise_parameter_sanitizer.for(:sign_up) {
				|u| u.permit(registration_params)
			}
		end
	end

	def after_sign_in_path_for(resource)
	  	if current_user.admin?
	  		session[:public] = "admin"
	  	else
	  		session[:public] = "users"
	  	end
	  	root_path
	end
end
