class SessionsController < ApplicationController

  def create

    if user = User.find_by(email: params[:email])
      session[:user_id] = user.id
      redirect_to reports_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to root_path
    end
  end

  # def bad
  #   flash[:error] = "Sorry, your credentials are bad."
  #   redirect_to root_path
  # end
end
