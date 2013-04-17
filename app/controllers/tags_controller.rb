class TagsController < ApplicationController
 #before_filter :user_signed_in, only: [:destroy]

   def index
    @tags = Tag.all
   end

	def show
		puts "in show----------------------------------"
     @tag = Tag.find(params[:id])
     puts "--------------------------------------",@tag.articles,"-------------------------------------"
     @tag
    end
end
