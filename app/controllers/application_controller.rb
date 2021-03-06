class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_any!, except: [:index]


  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :username, :latitude, :longitude, :avatar, :ip_address) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,
      :current_password, :username, :latitude, :longitude, :avatar, :ip_address) }

end


private
def authenticate_any!
    if user_signed_in?
        true
    else
        authenticate_business_user!
    end
end

# def after_sign_in_path_for(resource_or_scope)
#     if resource.sign_in_count == 1
#       new_product_path
#     else
#       root_path
#     end
# end

def after_sign_in_path_for(resource)
 if current_business_user
     if resource.sign_in_count == 1
       new_businessprofile_path(current_business_user) 
    else
       root_path
    end
else
 businessprofiles_path
end
end

end
