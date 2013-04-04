class CommentsController < ApplicationController
	def new
	  @comment = Comment.new
	end

	def create
	  @article = Article.find(params[:id])
	  @comment = current_user.comments.build(params[:comment])
	  @comment.article_id = @article.id
	  if @comment.save
	    flash[:success] = "Comment created!"
	    redirect_to article_path(@comment.article)
	  end
	end

	def destroy
	end

end