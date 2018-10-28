require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user, scope: :user)
    @movie = create(:movie, user: @user)
  end

  describe 'POST create' do
    context "logged in user with valid jwt" do
      it "should create new rating for user if no prev rating exist for the movie" do
        count = Rating.count
        post :create, params: {movie_id: @movie.id, value: 2.0, jwt: Auth.encode({email: @user.email})}, :format => 'json'
        expect(Rating.count).to eq(count + 1)
      end

      it "should update user prev rating if prev rating exist for the movie" do
        rating = create(:rating, movie: @movie, user: @user)
        count = Rating.count
        post :create, params: {movie_id: @movie.id, value: 3.0, jwt: Auth.encode({email: @user.email})}
        expect(Rating.count).to eq(count)
        expect(rating.reload.value).to eq(3.0)
      end
    end

    context "invalid user jwt" do
      it "should not create a new rating" do
        count = Rating.count
        post :create, params: {movie_id: @movie.id, value: 2.0, jwt: "invalid"}
        expect(Rating.count).to eq(count)
        expect(response.status).to eq(422)
      end
    end
  end
end
