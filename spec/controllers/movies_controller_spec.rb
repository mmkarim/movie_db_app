require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user, scope: :user)
    @movie = create(:movie, user: @user)
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET edit" do
    context "valid logged in user" do
      it "should render edit template" do
        get :edit, params: {id: @movie}
        expect(response).to render_template("edit")
      end
    end

    context "invalid user" do
      it "should redirect to sign in page if not logged in" do
        sign_out(:user)
        get :edit, params: {id: @movie}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "riderct to root url if movie not belong the user" do
        movie2 = create(:movie)
        get :edit, params: {id: movie2}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PUT update' do
    context "valid attributes" do
      it "located the requested @movie" do
        put :update, params: {id: @movie, movie: FactoryBot.attributes_for(:movie)}
        expect(assigns(:movie)).to eq(@movie)
      end

      it "should change @movie attributes" do
        put :update, params: {id: @movie, movie: {name: "Abc"}}
        expect(@movie.reload.name).to eq("Abc")
      end
    end

    context "invalid attributes" do
      it "should not change @movie attributes" do
        put :update, params: {id: @movie, movie: {name: nil}}
        @movie.reload
        expect(@movie.reload.name).not_to eq("Abc")
      end

      it "re-renders the edit method" do
        put :update, params: {id: @movie, movie: {name: nil}}
        expect(response).to render_template("edit")
      end
    end

    context "invalid user" do
      it "should redirect to sign in page if not logged in" do
        sign_out(:user)
        put :update, params: {id: @movie, movie: {name: "abc"}}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "riderct to root url if movie doesn't belong the user" do
        sign_out(:user)
        user2 = create(:user)
        sign_in(user2, scope: :user)
        put :update, params: {id: @movie, movie: {name: "abc"}}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET new" do
    it "should render new template if logged in" do
      get :new
      expect(response).to render_template("new")
    end

    it "should redirect to sign in page if not logged in" do
      sign_out(:user)
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST create" do
    it "should create new movie with proper params if logged in" do
      count = Movie.count
      post :create, params: {movie: {name: "abc", text: "text"}}
      expect(Movie.count).to eq(count + 1)
    end

    it "should redirect to sign in page if not logged in" do
      sign_out(:user)
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE destroy" do
    context "valid logged in user with valid jwt" do
      it "should be able to delete if movie belongs to user" do
        count = Movie.count
        delete :destroy, params: {id: @movie, jwt: Auth.encode({email: @user.email})}
        expect(Movie.count).to eq(count - 1)
      end

      it "should not be able to delete if movie not belongs to user" do
        movie2 = create(:movie)
        count = Movie.count
        delete :destroy, params: {id: movie2, jwt: Auth.encode({email: @user.email})}
        expect(Movie.count).to eq(count)
      end
    end

    context "invalid user" do
      it "should not be able to delete" do
        count = Movie.count
        delete :destroy, params: {id: @movie, jwt: "invalid"}
        expect(Movie.count).to eq(count)
      end
    end
  end
end
