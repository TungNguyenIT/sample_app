class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]

      if user.activated?
        login_remember user
      else
        flash[:warning] = t ".not_activate"
        redirect_to root_path
      end
    else
      flash[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def login_remember user
    log_in user

    if params[:session][:remember_me] == Settings.sessions.remember_me
      remember user
    else
      forget user
    end
    redirect_back_or user
    flash[:success] = t ".success"
  end
end
