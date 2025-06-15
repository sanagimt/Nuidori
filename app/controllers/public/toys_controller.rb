class Public::ToysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :index, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @user = User.find_by!(username: params[:username])
    @toys = @user.toys.page(params[:page]).per(12).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
  end

  def show
    @toy = Toy.find(params[:id])
    @user = @toy.user

    if !@user.is_active
      redirect_to root_path, alert: "このぬいぐるみは存在しません。"
      return
    end

    @posts = @toy.posts.includes(:user).page(params[:page]).per(9).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
  end

  def new
    @toy = Toy.new
  end

  def create
    @toy = Toy.new(toy_params)
    @toy.user_id = current_user.id
    if @toy.save
      redirect_to toy_path(@toy.id), notice: "ぬいぐるみの登録が完了しました！"
    else
      render :new
    end
  end

  def edit
    @toy = Toy.find(params[:id])
  end

  def update
    @toy = Toy.find(params[:id])
    @toy.user_id = current_user.id
    if @toy.update(toy_params)
      redirect_to toy_path(@toy.id), notice: "ぬいぐるみの更新が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @toy = Toy.find(params[:id])
    @toy.destroy
    redirect_to user_toys_path(@toy.user.username), alert: "ぬいぐるみを削除しました。"
  end

  def by_user
    user = User.find_by(id: params[:user_id])
      if user.nil?
        render json: [], status: :not_found and return
      end

      toys = user.toys.includes(:user)

      render json: toys.map { |toy|
        {
          id: toy.id,
          name: toy.name,
          user_nickname: toy.user.nickname,
          user_username: toy.user.username
        }
      }
  end

  private

  def toy_params
    params.require(:toy).permit(:toy_image, :name, :introduction)
  end

  def is_matching_login_user
    toy = Toy.find(params[:id])
    unless toy.user.id == current_user.id
      redirect_to mypage_path
    end
  end

end
