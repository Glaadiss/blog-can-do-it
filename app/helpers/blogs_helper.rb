module BlogsHelper

  def have_blog 
    blog = current_user.blogs.first
    if blog.blank?
      " <li> #{link_to "Stwórz bloga", new_blog_path} </li> ".html_safe
    else 
      " <li> #{link_to "Twój blog", blog_path(blog)} </li> <li> #{link_to "Dodaj artykuł ", new_blog_article_path(blog)} </li> ".html_safe
    end  
  end

end
