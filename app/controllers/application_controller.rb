class ApplicationController < ActionController::Base
  protect_from_forgery
    
    def authorize
      if current_user.nil? && current_photographer.nil?
        redirect_to :login
      end
    end

    
    def current_user
      if session[:user_id] 
        @current_user = User.find(session[:user_id])
      end
    end
    helper_method :current_user
        
    def current_photographer
      if session[:photographer_id]
        @current_photographer = Photographer.find(session[:photographer_id])
      end
    end
    helper_method :current_photographer
      
end
