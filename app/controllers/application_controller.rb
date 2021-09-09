class ApplicationController < ActionController::Base

  def current_user
    if session[:user_id].nil?
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
    end
  end
end
