class Admin::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content=params[:content]

    if @model == "post"
      @records = Post.search_for(@content).page(params[:page]).per(20)
    elsif @model == "user"
      @records = User.search_for(@content).page(params[:page]).per(20)
    end
  end
end
