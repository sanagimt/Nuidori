class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content=params[:content]

    if @model == "post"
      @records = Post.search_for(@content).page(params[:page]).per(12)
    elsif @model == "user"
      @records = User.search_for(@content).page(params[:page]).per(10)
    end
  end

end
