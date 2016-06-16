class BlogsController < ApplicationController

  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @blogs = Blog.all
  end

  def show  
    @blog = Blog.find(params[:id])
    @articles = @blog.articles.ordered
  end

  def new
    @blog = Blog.new
  end

  def edit
    
  end

  def update
    
    if @blog.update_attributes(blog_params)
      redirect_to blog_path(@blog), notice: 'Blog zaaktualizowany!'
    else
      render 'edit'
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blog_path(@blog), notice: 'Blog stworzony!'
    else
      render 'new'
    end
  end

  def destroy
    @blog.destroy
    redirect_to root_path, notice: 'Blog usunięty'
  end


  private

  def blog_params
    params.require(:blog).permit(:name, :body, :avatar)
  end

  private

  def owners_only
    @blog = Blog.find(params[:id])
    redirect_to root_path, notice: "Nie masz uprawnień do tej akcji" unless @blog.user_id == current_user.id
  end

end
