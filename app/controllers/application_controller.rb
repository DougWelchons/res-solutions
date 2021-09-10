class ApplicationController < ActionController::Base
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  # rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  #
  # def render_not_found(exception)
  #   flash[:error] = exception.message
  # end
  #
  # def render_invalid_record(exception)
  #   flash[:error] = exception.message
  # end

  def current_user
    if session[:user_id].nil?
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
    end
  end
end
