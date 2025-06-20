class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render 'error.js.erb' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
