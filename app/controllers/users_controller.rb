def show
    @user = User.find(params[:id])
    @article = @user.articles
  end