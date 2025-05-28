class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content=params[:content]

    if @model == "post"
      @records = Post.search_for(@content, include_inactive_users: true).page(params[:page]).per(12)
    elsif @model == "user"
      @records = User.search_for(@content, include_inactive: true).page(params[:page]).per(20)
    end
  end
end
