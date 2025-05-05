class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]

  def show
    @user = User.find[params[:id]]
    @posts = @user.posts
  end

  def mypage
    @user = current_user
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
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def favorites
  end
end
