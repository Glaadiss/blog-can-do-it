class ArticlesController < ApplicationController

  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_blog, only: [:show, :index, :new, :edit, :update, :create, :destroy]
  before_action :owners_only, only: [:edit, :update, :destroy]

  def all_articles
    @articles = Article.paginate(page: params[:page]).followed(params[:id]).ordered
    
  end

  def index    
    @articles = @blog.articles.ordered
  end

  def show  
    @article = Article.find(params[:id])
    @comments = @article.comments.paginate(page: params[:page]).ordered
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.blog_id = params[:blog_id]
    if @article.save
      redirect_to blog_article_path(@blog, @article),  notice: 'Artykuł stworzony!'
    else
      render 'new', alert: 'Źle wypełnione pola!'
    end
  end

  def edit  
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to blog_article_path(@blog, @article), notice: 'Artykuł zaktualizowany!'
    else
      render 'edit', alert: 'Źle wypełnione pola!'
    end
  end

  def destroy
    @article.destroy
    redirect_to blog_path(@blog), alert: 'Artykuł usunięty!'
  end


  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def article_params
    params.require(:article).permit(:name, :body)
  end

  def owners_only
    @article = Article.find(params[:id])
    redirect_to root_path, notice: "Nie masz uprawnień do tej akcji" unless @article.user_id == current_user.id
  end

end
