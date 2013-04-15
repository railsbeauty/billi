class CommentsController < ApplicationController
	 before_filter :user_signed_in, except: [:create]
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

	def destroy
	end

end