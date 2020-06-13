require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:post_) { create(:post, user_id: user.id) }
  let(:like) { build(:like, user_id: user.id, post_id: post_.id) }

  describe "POST #create" do
    context "before login" do
      it "returns a 302 response" do
        post "/likes/#{post_.id}/create"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/likes/#{post_.id}/create"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{post_.id}"
      end
    end
  end

  describe "POST #destroy" do
    context "before login" do
      it "returns a 302 response" do
        like.save
        post "/likes/#{post_.id}/destroy"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        like.save
        post "/likes/#{post_.id}/create"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{post_.id}"
      end
    end
  end
end
