
class ArticlesController < ApplicationController
  before_filter :is_user_admin, only: [:new, :create, :edit, :destroy]
   
    def is_user_admin
      redirect_to(action: :index) unless current_user.try(:is_admin?) 
      return false 
    end

	  def index
		  @articles = Article.all(:order => "created_at DESC")
      @article_titles = Article.first(10)
      @tags = Tag.all
	  end

    def show
       @article = Article.find(params[:id])
       @related_articles = Article
      .joins(:taggings)
      .where('id != ?', @article.id)
      .where(taggings: { tag_id: @article.tag_id })

    end

	  def new
      @article = Article.new
	  end

    def create
      @article = Article.new(params[:article])
      @article.user_id = current_user.id
      if @article.save
        flash[:success] = "article created!"
        redirect_to article_path(@article)
      else
        render 'new' 
      end 
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to action:  'index'	
    end

    def edit
      @article = Article.find(params[:id])
    end
    
    def update
      @article = Article.find(params[:id])
      if @article.update_attributes(params[:article])
       flash.notice = "Article '#{@article.title}' Updated!"
       redirect_to article_path(@article)
      else 
        render 'edit'
      end
    end
end

