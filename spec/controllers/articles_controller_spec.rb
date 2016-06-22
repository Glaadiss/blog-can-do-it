require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe 'quest user'  do
    let(:user) {FactoryGirl.create(:user)}
    let(:blog) {FactoryGirl.create(:blog)}
    let(:article1) {FactoryGirl.create(:article, blog: blog)}
    let(:article2) {FactoryGirl.create(:article, blog: blog, name: 'other article')}

    describe 'Get index' do
      it 'renders :index template' do
        get :index, blog_id: blog 
        expect('response').to render_template(:index)
      end

      it 'renders articles in order' do 
        get :index, blog_id: blog
        expect(assigns[:articles]).to match_array([article2, article1])
      end
    end

    describe 'Get show' do
      it 'renders :show template' do
        get :show, id:article1, blog_id: blog
        expect('response').to render_template(:show)
      end

      it 'assigns requested article to @article' do 
        get :show, id:article1, blog_id: blog
        expect(assigns(:article)).to eq(article1)      
      end
 
    end

    describe 'Get all_articles' do 
      it 'renders :all_articles template' do 
        get :all_articles, id: user
        expect('response').to render_template('all_articles')
      end
    end


    describe 'Get new' do 
      it 'redirects to new_user_session_path' do 
        get :new, blog_id: blog
        expect('response').to redirect_to(new_user_session_path)
      end
    end

    describe 'Post create' do 
      it 'redirects to new_user_session_path' do 
        post :create, blog_id: blog
        expect('response').to redirect_to(new_user_session_path)
      end
    end

    describe 'Get edit' do 
      it 'redirects to new_user_session_path' do 
        get :edit, blog_id: blog, id: article1
        expect('response').to redirect_to(new_user_session_path)
      end
    end

    describe 'Put update' do 
      it 'redirects to new_user_session_path' do 
        put :update, blog_id: blog, id: article1
        expect('response').to redirect_to(new_user_session_path)
      end
    end

    describe 'Delete destroy' do 
      it 'redirects to new_user_session_path' do 
        delete :destroy, blog_id: blog, id:article1
        expect('response').to redirect_to(new_user_session_path)
      end
    end


  end


  describe 'authenticated user' do 
    let(:user) {FactoryGirl.create(:user)}
    let(:blog) {FactoryGirl.create(:blog, user: user)}

    before do
      sign_in(user)
    end

    describe 'Get new' do 
      it 'renders :new template' do 
        get :new, blog_id: blog
        expect('response').to render_template(:new)
      end

      it 'assigns new Article to @article' do  
        get :new, blog_id: blog
        expect(assigns(:article)).to be_a_new(Article)
      end
    end

    describe 'Post create' do 
      let(:valid_data) { FactoryGirl.attributes_for(:article, user: user, blog: blog)}
      let(:invalid_data) { FactoryGirl.attributes_for(:article,user: user, blog: blog, name:'')}
      context 'valid data' do 
        it 'redirects to article path' do 
          post :create, article: valid_data, blog_id: blog
          expect('response').to redirect_to( blog_article_path(blog.id, assigns[:article]))
        end
        it 'creates new article in database' do  
          expect {post :create, article: valid_data, blog_id: blog }.to change(Article, :count).by(1)
        end
      end
      
      context 'invalid data' do 
        it 'renders :new templalte' do 
          post :create, article: invalid_data, blog_id: blog
          expect('response').to render_template(:new)
        end
        it "doesn't create new article in databse" do  
          expect {post :create, article: invalid_data, blog_id: blog }.not_to change(Article, :count)
        end
      end
    end

    context 'user is not an owner' do 
      let(:article) {FactoryGirl.create(:article)}
      describe 'Get edit' do 
        it 'redirects to root_path ' do 
          get :edit, blog_id: article.blog, id: article
          expect('response').to redirect_to(root_path)
        end
      end

      describe 'Put update' do 
        it 'redirects to root_path ' do 
          put :update, blog_id: article.blog, id: article
          expect('response').to redirect_to(root_path)
        end
      end

      describe 'Delete destroy' do 
        it 'redirects to root_path ' do 
          delete :destroy, blog_id: article.blog, id: article
          expect('response').to redirect_to(root_path)
        end
      end

    end

    context 'user is an owner' do 
      let(:article) {FactoryGirl.create(:article, user: user, blog: blog)}
      describe 'Get edit' do 

        it 'renders :edit template' do  
          get :edit, blog_id: blog, id: article
          expect('respone').to render_template(:edit)
        end

        it 'assigns requested article to edit' do 
          get :edit, blog_id: blog, id: article
          expect(assigns(:article)).to eq(article)
        end

      end

      describe 'Put update' do 
        context 'valid data' do  
          
          let(:valid_data){FactoryGirl.attributes_for(:article, name: 'HeHeHeHeHe', user: user, blog: blog)} 
          
          it 'redirects to blog_article_path' do 
            put :update, blog_id: blog, id: article, article: valid_data
            expect('respone').to redirect_to(blog_article_path(blog,article))
          end

          it 'update article in database' do 
            put :update, blog_id: blog, id: article, article: valid_data
            article.reload
            expect(article.name).to eq('HeHeHeHeHe')
          end
        end

        context 'invalid_data' do 
          
          let(:invalid_data) {FactoryGirl.attributes_for(:article, name:'', user: user, blog: blog)}

          it 'renders :edit template' do 
            put :update, blog_id: blog, id: article, article: invalid_data
            expect('respone').to render_template(:edit)
          end

          it "doesn't update article in databse" do 
            put :update, blog_id: blog, id: article, article: invalid_data
            article.reload
            expect(article.name).not_to eq('')
          end
        end
      end

      describe 'Delete destroy' do 
        it 'redirects to blog_path ' do 
          delete :destroy, blog_id: blog, id:article
          expect('respone').to redirect_to(blog_path(blog))
        end

        it 'delete article from database' do 
          delete :destroy, blog_id: blog, id:article
          expect(Article.exists?(article.id)).to be_falsy
        end
      end

    end
  
  end
end
