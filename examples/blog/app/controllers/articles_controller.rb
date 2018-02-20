class ArticlesController < ApplicationController

	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def create
		@article = Article.create(
				params
					.require(:article)
					.permit(:title, :description)
				)
		redirect_to articles_path		
	end

end
