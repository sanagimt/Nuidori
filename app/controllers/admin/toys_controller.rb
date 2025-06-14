class Admin::ToysController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @toys = @user.toys.page(params[:page]).per(12).joins(:user).order(id: :asc)
  end

  def show
    @toy = Toy.find(params[:id])
    @user = @toy.user
  end

  def destroy
    @toy = Toy.find(params[:id])
    @toy.destroy
    redirect_to admin_user_toys_path(@toy.user_id), alert: "ぬいぐるみを削除しました。"
  end

end