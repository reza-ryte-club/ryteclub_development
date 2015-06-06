class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_location
  #before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
    
    def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
      return unless request.get? 
      if (!request.fullpath.match("/users") &&
        !request.xhr?) # don't store ajax calls
         session["user_return_to"] = request.fullpath
      end
    end
    
    def ensure_signup_complete
      # Ensure we don't go into an infinite loop
      return if action_name == 'finish_signup'

      # Redirect to the 'finish_signup' page if the user
      # email hasn't been verified yet

      if current_user && !current_user.email_verified?
        redirect_to finish_signup_path(current_user)
      end
    end
    

    private
      def after_sign_in_path_for(resource)
        profiles_index_path(current_user.id)
        #session["user_return_to"] || root_path
      end
 
    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :firstname, :lastname, :username) }
      end


  def authenticate_user
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path
    end
  end


end
