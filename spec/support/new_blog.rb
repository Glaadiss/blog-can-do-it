class NewBlogForm
  include Capybara::DSL


  def visit_blog_form
    visit('/')
    click_on 'Stwórz bloga'
    self
  end

  def fill_in_with( name, body)
    fill_in 'Nazwa bloga', with: name
    fill_in "Opis Bloga", with: body
    click_button 'Utwórz Blog'
    self
  end



end