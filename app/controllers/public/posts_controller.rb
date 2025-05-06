class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.joins(:user).where(users: { is_active: true })
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user

    if !@user.is_active
      redirect_to root_path, alert: "この投稿は存在しません。"
      return
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to mypage_path, notice: "投稿が完了しました！"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿が完了しました！"
    else
      render :edit
    end
  end

  def destroy
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body)
  end

end
