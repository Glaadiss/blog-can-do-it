module UsersHelper

  def blog(user)
    if user.blogs.first
      blog_path(user.blogs.first)
    else
      '#'
    end
  end

end