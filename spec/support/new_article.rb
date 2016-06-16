class NewArticleForm
  include Capybara::DSL


  def visit_article_form
    visit('/')
    click_on 'Dodaj artykuł'
    self
  end

  def fill_in_with( name, body)
    fill_in 'Nazwa artykułu',  with: name
    fill_in "Treść", with: body
    click_button 'Dodaj artykuł'
    self
  end



end