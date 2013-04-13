class CommentsController < ApplicationController
	 before_filter :signed_in_user
	def new
	  @comment = Comment.new
	end

	def create
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.build(params[:comment])
	  @comment.user_id = current_user.id
	  if @comment.save
	    flash[:success] = "Comment created!"
	    redirect_to article_path(@comment.article)
	  end
	end

	def destroy
	end

end