class DraftsController < ApplicationController
  def index
      @articles = Article.where(is_draft:  true)
     # @articles = Article.all
      @article_titles = Article.first(10)
      @tags = Tag.all
      #@articles = Article.paginate(:page => params[:page], :per_page => 5)
    end
end
