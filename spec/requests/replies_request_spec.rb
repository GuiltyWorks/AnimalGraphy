require "rails_helper"

RSpec.describe "Replies", type: :request do
  let(:user) { create(:user) }
  let(:post_) { create(:post) }

  before do
    @reply = create(:reply, post_id: post_.id, user_id: user.id)
  end

  describe "POST #create" do
    context "before login" do
      it "does not change Reply counts" do
        expect {
          post replies_path, params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        }.to change(Reply, :count).by(0)
      end

      it "returns a 302 response" do
        post replies_path, params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      before do
        sign_in user
      end

      it "increases Reply counts" do
        expect {
          post replies_path, params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        }.to change(Reply, :count).by(1)
      end

      it "returns a 302 response" do
        post replies_path, params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{post_.id}"
      end
    end
  end

  describe "GET #edit" do
    context "before login" do
      it "returns a 302 response" do
        get "/replies/#{@reply.id}/edit"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/replies/#{@reply.id}/edit"
        expect(response).to have_http_status 200
        expect(response).to render_template "replies/edit", "layouts/application"
      end
    end
  end

  describe "PATCH #update" do
    context "before login" do
      it "returns a 302 response" do
        patch "/replies/#{@reply.id}", params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        patch "/replies/#{@reply.id}", params: { reply: { post_id: post_.id, comment: "Test Comment." } }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@reply.post_id}"
      end
    end
  end

  describe "DELETE #destroy" do
    context "before login" do
      it "does not change Reply counts" do
        expect {
          delete "/replies/#{@reply.id}"
        }.to change(Reply, :count).by(0)
      end

      it "returns a 302 response" do
        delete "/replies/#{@reply.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      before do
        sign_in user
      end

      it "decreases Reply counts" do
        expect {
          delete "/replies/#{@reply.id}"
        }.to change(Reply, :count).by(-1)
      end

      it "returns a 302 response" do
        delete "/replies/#{@reply.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@reply.post_id}"
      end
    end
  end
end
