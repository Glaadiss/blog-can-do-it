require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  
  shared_examples 'public access to blogs' do
    describe 'Get index' do
      let(:blog1) { FactoryGirl.create(:blog)}
      let(:blog2) { FactoryGirl.create(:blog, name: 'qweeee') }
      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'renders blogs' do 
        get :index
        expect(assigns(:blogs)).to match_array([blog1, blog2])
      end

    end

    describe 'GET show' do
      let(:blog) {FactoryGirl.create(:blog)}
      it 'renders :show template' do 
        get :show, id: blog
        expect(response).to render_template(:show)
      end
      it 'assigns requested blog to @blog' do 
        get :show, id: blog
        expect(assigns(:blog)).to eq(blog)
      end
    end    
  end

  describe 'quest user' do

    it_behaves_like 'public access to blogs'
    describe 'GET new' do 
      it 'redirects to new_user_session_path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      let(:valid_data) { FactoryGirl.attributes_for(:blog) }
      it 'redirects to new_user_session_path' do
        post :create, blog: valid_data
        expect(response).to redirect_to(new_user_session_path)
      end 
    end

    describe 'GET edit' do
      let(:blog) {FactoryGirl.create(:blog)}
      it 'redirects to new_user_session_path' do
        get :edit, id: blog
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT update' do 
      let(:blog) {FactoryGirl.create(:blog)}
      let(:valid_data) {FactoryGirl.attributes_for(:blog, name: 'Nowy Blog')}
      it 'redirects to new_user_session_path' do
        put :update, id: blog, blog: valid_data
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      let(:blog) {FactoryGirl.create(:blog)}
      it 'redirects to new_user_session_path' do
        delete :destroy, id: blog
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe 'authenticated user' do 
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in(user)
    end

    it_behaves_like 'public access to blogs'

    describe 'GET new' do 
      it 'renders :new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns new Blog to @blog' do
        get :new
        expect(assigns(:blog)).to be_a_new(Blog)
      end
    end

    describe 'POST create' do
      context "valid data" do 
        let(:valid_data) { FactoryGirl.attributes_for(:blog) }
        it "redirects to root_path " do
          post :create, blog: valid_data
          expect(response).to redirect_to(blog_path(assigns[:blog]))
        end

        it "creates new blog in database" do
          expect { post :create, blog:valid_data }.to change(Blog, :count).by(1)
        end   
      end

      context "invalid data" do
        let(:invalid_data) {FactoryGirl.attributes_for(:blog, name: ' ')}
        it 'render :new template' do
          post :create, blog: invalid_data
          expect(response).to render_template(:new)

        end
        it " doesn't created new blog in database" do 
          expect { post :create, blog: invalid_data}.not_to change(Blog, :count)
        end
      end
    end


    context 'user is not the owner' do
      let(:blog) {FactoryGirl.create(:blog)}
      describe 'GET edit' do
        it 'renders :edit template' do
          get :edit, id: blog
          expect(response).to redirect_to(root_path)
        end
      end

      describe 'PUT update' do 
        let(:valid_data) {FactoryGirl.attributes_for(:blog, name: 'Nowy Blog')}
        it 'redirects to blog_path ' do
          put :update, id: blog, blog: valid_data
          expect(response).to redirect_to(root_path)
        end
      end


      describe 'DELETE destroy' do
        it 'redirects to root_path' do
          delete :destroy, id: blog
          expect(response).to redirect_to(root_path)
        end
      end

    end

    context 'user is the owner' do

      let(:blog) {FactoryGirl.create(:blog, user: user)}

      describe 'GET edit' do
        it 'renders :edit template' do
          get :edit, id: blog
          expect(response).to render_template(:edit)
        end
        it 'assigns requested blog to edit' do 
          get :edit, id: blog
          expect(assigns(:blog)).to eq(blog)
        end
      end
      describe 'PUT update' do   
        context "valida data " do 
          let(:valid_data) {FactoryGirl.attributes_for(:blog, name: 'Nowy Blog')}
          it 'redirects to blog_path ' do
            put :update, id: blog, blog: valid_data
            expect(response).to redirect_to(blog_path(assigns[:blog]))
          end
          it 'update blog in database' do
            put :update, id: blog, blog: valid_data
            blog.reload
            expect(blog.name).to eq('Nowy Blog')
          end
        end
        context "invalid data" do
          let(:invalid_data) {FactoryGirl.attributes_for(:blog, name: '')}
          it 'render :edit ' do
            put :update, id: blog, blog: invalid_data
            expect(response).to render_template(:edit)
          end
          it  " doesn't updated blog in database " do
            put :update, id: blog, blog: invalid_data
            blog.reload
            expect(blog.name).not_to eq('Nowy Blog')
          end
        end
      end
      describe 'DELETE destroy' do
        it 'redirects to root_path' do
          delete :destroy, id: blog
          expect(response).to redirect_to(root_path)
        end
        it 'deletes blog from database' do
          delete :destroy, id: blog
          expect(Blog.exists?(blog.id)).to be_falsy
        end

      end

    end
  end
end
