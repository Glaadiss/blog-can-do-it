require 'rails_helper'
require_relative '../support/new_user'

feature 'home_page' do  
  let(:new_user_form) { NewUserForm.new }


  scenario 'good register' do
    new_user_form.visit_root.fill_in_with( 'aaa', 'aaa@gmail.com', '12345678', '12345678' )
    expect(page).to have_content("Witaj! Zarejestrowałeś się pomyślnie.")
  end 

  scenario 'bad register' do
    new_user_form.visit_root.fill_in_with( '', '', '12345678', '12345678' )
    expect(page).to have_content("nie może być puste")

  end

  
  
end