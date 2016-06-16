require 'rails_helper'
require_relative '../support/new_article'
require_relative '../support/login_form'
feature 'create_article' do  

  let(:new_article_form) { NewArticleForm.new }
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryGirl.create(:user)}

  background do
    login_form.visit_page.login_as(user)
    blog = FactoryGirl.create(:blog, user: user)
    visit('/')
  end

  scenario 'good article create' do
    new_article_form.visit_article_form.fill_in_with( 'Chicken', 'Super extra mega chicken xd xd xdddd' )
    click_on 'Twój blog'
    expect(page).to have_content('Chicken')
    click_on "Chicken"
    expect(page).to have_content('Super extra mega chicken xd xd xdddd' )
  end 
end