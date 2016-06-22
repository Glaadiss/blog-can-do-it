class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_blog_article
  before_action :owners_only, only: [:edit, :update, :destroy]

  def index    
    @comments = @article.comments.paginate(page: params[:page]).ordered
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.article_id = params[:article_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_article_path(@blog,@article) , notice: 'User was successfully created.' }
        format.js 
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors }
      end
    end
  end

  def edit  
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to blog_article_path(@blog, @article), notice: 'Komentarz zaktualizowany!'
    else
      render 'edit', alert: 'Źle wypełnione pola!'
    end
  end

  def destroy
    @comment.destroy
    redirect_to blog_article_path(@blog, @article), alert: 'Komentarz usunięty!'
  end


  private

  def set_blog_article
    @blog = Blog.find(params[:blog_id])
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def owners_only
    @article = Article.find(params[:id])
    redirect_to root_path, notice: "Nie masz uprawnień do tej akcji" unless @comment.user_id == current_user.id or @article.user_id == current_user.id
  end

end
