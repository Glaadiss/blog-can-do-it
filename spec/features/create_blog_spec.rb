require 'rails_helper'
require_relative '../support/new_blog'
require_relative '../support/login_form'
feature 'create_blog' do  

  let(:new_blog_form) { NewBlogForm.new }
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryGirl.create(:user)}

  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'good blog create' do
    new_blog_form.visit_blog_form.fill_in_with( 'Gotowanie', 'Blog o gotowaniu itd' )
    expect(page).to have_content("Gotowanie")
    expect(page).to have_content("Blog o gotowaniu itd")
  end 


  

end