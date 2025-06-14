class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(15)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @toys = @post.toys.includes(:user)
    @comments = @post.comments.all
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, alert: "投稿を削除しました。"
  end

end
