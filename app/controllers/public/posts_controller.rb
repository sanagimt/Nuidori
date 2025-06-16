class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy, :hashtag]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    mutual_users = (current_user.mutual_followings + [current_user]).select(&:is_active)
    @users = mutual_users.uniq.sort_by(&:nickname)
    @toys = Toy.includes(:user).where(user: mutual_users)
    @selected_toys = []
  end

  def index
    if params[:filter] == 'following' && user_signed_in?
      followed_user_ids = current_user.followings.pluck(:id)
      @posts = Post.joins(:user)
                   .where(user_id: followed_user_ids, users: { is_active: true })
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(12)
    else
      @posts = Post.joins(:user)
                   .where(users: { is_active: true })
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(12)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user

    if !@user.is_active
      redirect_to root_path, alert: "この投稿は存在しません。"
      return
    end

    @toys = @post.toys.joins(:user).where(users: { is_active: true })
    @comment = Comment.new
    @comments = @post.comments.joins(:user).where(users: { is_active: true }).order(created_at: :desc)

  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿が完了しました！"
    else
      mutual_users = (current_user.mutual_followings + [current_user]).select(&:is_active)
      @users = mutual_users.uniq.sort_by(&:nickname)
      @toys = Toy.includes(:user).where(user: mutual_users)
      @selected_toys = []
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    mutual_users = (current_user.mutual_followings + [current_user]).select(&:is_active)
    @users = mutual_users.uniq.sort_by(&:nickname)
    @toys = Toy.includes(:user).where(user: mutual_users)
    @selected_toys = @post.toys.includes(:user).where(users: { is_active: true })
    @selected_toys_json = @selected_toys.map do |toy|
      {
        id: toy.id,
        name: toy.name,
        user_nickname: toy.user.nickname,
        user_username: toy.user.username
      }
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.touch unless @post.previous_changes.any?
      redirect_to post_path(@post.id), notice: "投稿を更新しました！"
    else
      mutual_users = (current_user.mutual_followings + [current_user]).select(&:is_active)
      @users = mutual_users.uniq.sort_by(&:nickname)
      @toys = Toy.includes(:user).where(user: mutual_users)
      @selected_toys = @post.toys.includes(:user).where(users: { is_active: true })
      @selected_toys_json = @selected_toys.map do |toy|
        {
          id: toy.id,
          name: toy.name,
          user_nickname: toy.user.nickname,
          user_username: toy.user.username
        }
      end
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_path, alert: "投稿を削除しました。"
  end

  def hashtag
    @model = 'hashtag'
    @content = params[:name]
  
    hashtag = Hashtag.find_by(name: @content.downcase)
    if hashtag
      @records = hashtag.posts.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    else
      @records = Post.none.page(params[:page])
    end
  
    render 'public/posts/hashtag'
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body, toy_ids: [] )
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end
