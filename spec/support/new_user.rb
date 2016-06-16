class NewUserForm
  include Capybara::DSL


  def visit_root
    visit('/')
    self
  end

  def fill_in_with( name, email, passw, vpassw )
    fill_in 'Adres e-mail', match: :first,  with: email
    fill_in "Name", with: name
    fill_in "Hasło",  match: :first,  with: passw
    fill_in 'Potwierdzenie hasła',  with: vpassw  
    click_button 'Zarejestruj'
    self
  end



end