require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }

  describe "POST #create" do
    before do
      @post = create(:post, user_id: user.id)
    end

    context "before login" do
      it "does not change Like counts" do
        expect {
          post likes_path, params: { id: @post.id }
        }.to change(Like, :count).by(0)
      end

      it "returns a 302 response" do
        post likes_path, params: { id: @post.id }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      before do
        sign_in user
      end

      it "increases Like counts" do
        expect {
          post likes_path, params: { id: @post.id }
        }.to change(Like, :count).by(1)
      end

      it "returns a 302 response" do
        post likes_path, params: { id: @post.id }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@post.id}"
      end
    end
  end

  describe "POST #create with duplicate like" do
    before do
      @post = create(:post, user_id: user.id)
      create(:like, user_id: user.id, post_id: @post.id)
    end

    context "before login" do
      it "does not change Like counts" do
        expect {
          post likes_path, params: { id: @post.id }
        }.to change(Like, :count).by(0)
      end

      it "returns a 302 response" do
        post likes_path, params: { id: @post.id }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "does not change Like counts" do
        sign_in user
        expect {
          post likes_path, params: { id: @post.id }
        }.to change(Like, :count).by(0)
      end

      it "returns a 302 response" do
        sign_in user
        post likes_path, params: { id: @post.id }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@post.id}"
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @post = create(:post, user_id: user.id)
      create(:like, user_id: user.id, post_id: @post.id)
    end

    context "before login" do
      it "does not change Like counts" do
        expect {
          delete "/likes/#{@post.id}"
        }.to change(Like, :count).by(0)
      end

      it "returns a 302 response" do
        delete "/likes/#{@post.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "decreases Like counts" do
        sign_in user
        expect {
          delete "/likes/#{@post.id}"
        }.to change(Like, :count).by(-1)
      end

      it "returns a 302 response" do
        sign_in user
        delete "/likes/#{@post.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@post.id}"
      end
    end
  end
end
