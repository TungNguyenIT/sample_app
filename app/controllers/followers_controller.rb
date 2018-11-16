class FollowersController < ApplicationController
  before_action :logger_in_user

  def index
    @title = t ".follower"
    @user = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page]).per Settings.per_page
    render "users/show_follow"
  end
end
