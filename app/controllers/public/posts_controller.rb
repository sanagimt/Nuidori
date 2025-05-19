class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page]).per(12).joins(:user).where(users: { is_active: true }).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments.joins(:user).where(users: { is_active: true }).order(created_at: :desc)

    if !@user.is_active
      redirect_to root_path, alert: "この投稿は存在しません。"
      return
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿が完了しました！"
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
      @post.touch unless @post.previous_changes.any?
      redirect_to post_path(@post.id), notice: "投稿が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_path, alert: "投稿を削除しました。"
  end

  def hashtag
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end
