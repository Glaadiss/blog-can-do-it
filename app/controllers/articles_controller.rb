class ArticlesController < ApplicationController

  before_action :set_blog, only: [:show, :index, :new]

  def all_articles
    @articles = Article.followed(current_user.id).ordered
    
  end

  def index
    
    @articles = @blog.articles.ordered
  end

  def show  
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.blog_id = params[:blog_id]
    if @article.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  end


  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def article_params
    params.require(:article).permit(:name, :body)
  end

end
