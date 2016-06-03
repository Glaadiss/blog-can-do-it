class BlogsController < ApplicationController



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

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
  end


  private

  def blog_params
    params.require(:blog).permit(:name, :body, :avatar)
  end

end
