class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update, :unsubscribe, :withdraw]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy, :unsubscribe, :withdraw]

  def show
    @user = User.find_by!(username: params[:username])
    @posts = @user.posts.page(params[:page]).per(9).joins(:user).where(users: { is_active: true }).order(created_at: :desc)

    if !@user.is_active
      redirect_to root_path, alert: "このユーザーは存在しないか、退会しています。"
      return
    end
  end

  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(9).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
    render :show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'ユーザー情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    user = current_user
    user.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会が完了しました'
  end

  def favorites
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :last_name, :first_name, :email, :username, :nickname, :introduction)
  end

  def is_matching_login_user
    unless current_user
      redirect_to mypage_path
    end
  end

end
