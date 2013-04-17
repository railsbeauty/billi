class TagsController < ApplicationController
 #before_filter :user_signed_in, only: [:destroy]

   def index
    @tags = Tag.all
   end

	def show
     @tag = Tag.find(params[:id])
    end
end
