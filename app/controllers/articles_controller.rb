class ArticlesController < ApplicationController
	def index
		@articles = Article.all
		respond_to do |format|
			format.html
		end
	end
	def new
		@article = Article.new
		
	end
	def edit
		@article = Article.find(params[:id])
		
	end
	def show
		@article = Article.find(params[:id])
	end
	def create
		@article = Article.new(params[:article])
		if @article.save
			redirect_to articles_path, :notice => "your article saved"
		else
		render "new"
		end	
		
	end
	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(params[:article])
			redirect_to articles_path, :notice => "your article updated"
		else
		render "edit"
		end	
		
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path, :notice => "your article has deleted"	
		
	end
end
