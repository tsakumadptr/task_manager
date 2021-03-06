class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def auth_user
    if !@current_user
      flash[:notice] = "You don't have authority"
      redirect_to "/login"
      return
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  


end
