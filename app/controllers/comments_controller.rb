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
     
    def edit
      @comment = Comment.find(params[:id])
     end

   def update
    @comment = Comment.find(params[:id])
    @article = @comment.article
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        redirect_to article_path(@comment.article)
      else
       render  'edit' 
      end
    end
  end

	def destroy
     @comment = Comment.find(params[:id])
     @article = Article.find(params[:article_id])
     @comment.destroy
     redirect_to(@article_path(@article) 
    end
 

end