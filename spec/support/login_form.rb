class LoginForm 
  include Capybara::DSL
  def visit_page
    visit('/users/sign_in')
    self
  end

  def login_as(user)
    fill_in 'Adres e-mail', with: user.email
    fill_in "Hasło",  with: user.password
    click_button 'Log in'
    self
  end

end