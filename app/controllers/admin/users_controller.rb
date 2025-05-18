class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報の更新が完了しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :last_name, :first_name, :email, :username, :nickname, :introduction, :is_active)
  end

end
