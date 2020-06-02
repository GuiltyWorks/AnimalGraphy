require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:post_) { create(:post, user_id: user.id) }

  describe "GET #index" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/index"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/index"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #new" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/new"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/new"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/new", "layouts/application"
      end
    end
  end

  describe "GET #tags" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #edit" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/#{post_.id}/edit"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/#{post_.id}/edit"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/edit", "layouts/application"
      end
    end
  end

  describe "GET #show" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/#{post_.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/show", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/#{post_.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/show", "layouts/application"
      end
    end
  end

  describe "POST #create" do
    context "before login" do
      it "returns a 302 response" do
        post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/posts/create", params: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end
  end

  describe "POST #update" do
    context "before login" do
      it "returns a 302 response" do
        post "/posts/#{post_.id}/update", params: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/posts/#{post_.id}/update", params: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{post_.id}"
      end
    end
  end

  describe "POST #destroy" do
    context "before login" do
      it "returns a 302 response" do
        post "/posts/#{post_.id}/destroy"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        post "/posts/#{post_.id}/destroy"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end
  end
end
