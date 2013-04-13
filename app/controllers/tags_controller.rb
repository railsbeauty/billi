class TagsController < ApplicationController
 before_filter :user_signed_in, only: [:destroy]
	def show
     @tag = Tag.find(params[:id])
    end
end
