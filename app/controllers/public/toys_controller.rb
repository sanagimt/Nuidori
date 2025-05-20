class Public::ToysController < ApplicationController
  def index
    @user = User.find_by!(username: params[:username])
    @toys = Toy.page(params[:page]).per(12).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
  end

  def show
    @toy = Toy.find(params[:id])
    @user = @toy.user
    @posts = @toy.posts.includes(:user)
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
  end

  def update
  end

  private

  def toy_params
    params.require(:toy).permit(:toy_image, :name, :introduction)
  end

end
