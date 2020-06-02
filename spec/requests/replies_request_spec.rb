require "rails_helper"

RSpec.describe "Replies", type: :request do
  let(:user) { create(:user) }
  let(:post_) { create(:post) }
  let(:reply) { create(:reply, user_id: user.id) }

  describe "GET #edit" do
    context "before login" do
      it "returns a 302 response" do
        get "/replies/#{reply.id}/edit"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/replies/#{reply.id}/edit"
        expect(response).to have_http_status 200
        expect(response).to render_template "replies/edit", "layouts/application"
      end
    end
  end

  describe "POST #create" do
    context "before login" do
      it "returns a 302 response" do
        post "/replies/#{post_.id}/create", params: { comment: "Test Comment." }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/replies/#{post_.id}/create", params: { comment: "Test Comment." }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{post_.id}"
      end
    end
  end

  describe "POST #update" do
    context "before login" do
      it "returns a 302 response" do
        post "/replies/#{reply.id}/update", params: { comment: "Test Comment." }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/replies/#{reply.id}/update", params: { comment: "Test Comment." }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{reply.post_id}"
      end
    end
  end

  describe "POST #destroy" do
    context "before login" do
      it "returns a 302 response" do
        post "/replies/#{reply.id}/destroy"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/replies/#{reply.id}/destroy"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{reply.post_id}"
      end
    end
  end
end
