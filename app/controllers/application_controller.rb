class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for (resource) # Redirect users after sign-in&override Devises's default behavior.
    wikis_path 
  end
 
   protected
 
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :name
   end

   def update_user_to_premium
    current_user.update_attributes(role: "premium")
   end

   def downgrade_user_to_standard
    current_user.update_attributes(role: "standard")
   end
end
