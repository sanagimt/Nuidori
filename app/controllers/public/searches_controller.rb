class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content=params[:content]
    @records=Post.search_for(@content)

    if @model == "post"
      @records = Post.search_for(@content)
    elsif @model == "user"
      @records = User.search_for(@content)
    end
  end

end
