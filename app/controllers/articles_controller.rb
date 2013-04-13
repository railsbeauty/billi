
class ArticlesController < ApplicationController
  before_filter :is_user_admin, only: [:new, :create]

  def is_user_admin
    unless  current_user.is_admin?
      :root 
      return false

    end
  end

	def index
		@articles = Article.all(:order => "created_at DESC")
	end

    def show
      @article = Article.find(params[:id])
    end

	def new
      @article = Article.new
	end

    def create
      @article = Article.new(params[:article])
      @article.user_id = current_user.id
      @article.save
      redirect_to article_path(@article)
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
      @article.update_attributes(params[:article])
      flash.notice = "Article '#{@article.title}' Updated!"
      redirect_to article_path(@article)
     end
end

