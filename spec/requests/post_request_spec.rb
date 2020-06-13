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

  describe "GET #search (keyword: '')" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/search", params: { keyword: "" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/search", params: { keyword: "" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end
  end

  describe "GET #search (keyword: Test)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/search", params: { keyword: "Test" }
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/search", params: { keyword: "Test" }
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: all)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/all"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/all"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: monthly)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/monthly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/monthly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: weekly)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/weekly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/weekly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: daily)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/daily"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/daily"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: wrong-period)" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/ranking/wrong-period"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/ranking/wrong-period"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end
  end

  describe "GET #tags (tag: bird)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/bird"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/bird"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: cat)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: dog)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/dog"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/dog"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: horse)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/horse"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/horse"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: sheep)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/sheep"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/sheep"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: cow)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/cow"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/cow"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: elephant)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/elephant"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/elephant"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: bear)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/bear"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/bear"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: zebra)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/zebra"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/zebra"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: giraffe)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/giraffe"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/giraffe"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end
  end

  describe "GET #tags (tag: wrong-tag)" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/tags/wrong-tag"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/tags/wrong-tag"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/index"
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
