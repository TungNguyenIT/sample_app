class UsersController < ApplicationController
  before_action :logger_in_user, only: %i(index edit update)
  before_action :admin_user, only: :destroy
  before_action :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.page(params[:page]).per Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t ".check_your_email"
      redirect_to root_url
    else
      flash[:danger] = t ".faild"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update"
      redirect_to @user
    else
      render :edit
      flash[:danger] = t ".not_success"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".user_delete"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logger_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".require_login"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless @user.current_user? current_user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "not_find"
    redirect_to root_path
  end
end
