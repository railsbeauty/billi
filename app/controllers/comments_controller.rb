class CommentsController < ApplicationController
	
	def new
	  @comment = Comment.new
	end
  
	def create
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.build(params[:comment])
	  @comment.user_id = current_user.id
	  @comment.save
	    flash[:success] = "Comment created!"
	    redirect_to article_path(@comment.article)
	end

    def edit
     @comment =  Comment.find(params[:id])
     @article = @comment.article
     # @article = Article.find(params[:article_id])
     #@comment = @article.comments
    end   

    def update
     @comment = Comment.find(params[:id])
     @article = @comment.article
      if @comment.update_attributes(params[:comment])
        flash[:success] = "Comment updated!"
        redirect_to article_path(@article)
      else
       render :action => "edit" 
      end
    end

	def destroy

      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article) 
	end

end
