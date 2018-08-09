class ArticlesController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "password",
	except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article, :flash => { :success => "Post Saved Successfully!"}
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article, :flash => { :success => "Post Updated Successfully!" }
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path, :flash => { :error => "Post Deleted Successfully!" }
	end

	private 
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
