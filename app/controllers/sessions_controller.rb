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

  def destroy
    session.delete :user_id
    flash[:message] = 'You have been logged out.'
    redirect_to root_path
  end
end
