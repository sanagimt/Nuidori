class Public::ToysController < ApplicationController
  def index
    @user = User.find_by!(username: params[:username])
    @toys = @user.toys.page(params[:page]).per(12).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
  end

  def show
    @toy = Toy.find(params[:id])
    @user = @toy.user
    @posts = @toy.posts.includes(:user).page(params[:page]).per(9)
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
      render :new
    end
  end

  def by_user
    toys = Toy.where(user_id: params[:user_id])
    render json: toys.map { |toy| { id: toy.id, name: toy.name } }
  end

  private

  def toy_params
    params.require(:toy).permit(:toy_image, :name, :introduction)
  end

end
