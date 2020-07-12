require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  before do
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt").reject { |label| label.chomp == "other" }
    labels.each do |label|
      create(:tag, name: label.chomp)
    end
  end

  describe "GET #index" do
    context "before login" do
      it "returns a 200 response" do
        get posts_path
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get posts_path
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
        expect(response).to redirect_to posts_path
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/search", params: { keyword: "" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe "GET #search (keyword: Test)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/search", params: { keyword: "Test" }
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/search", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/search", params: { keyword: "Test" }
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/search", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: all)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/all"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/all"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: monthly)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/monthly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/monthly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: weekly)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/weekly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/weekly"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: daily)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/ranking/daily"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/ranking/daily"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/ranking", "layouts/application"
      end
    end
  end

  describe "GET #ranking (period: wrong-period)" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/ranking/wrong-period"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/ranking/wrong-period"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe "GET #tags (トリ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'トリ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'トリ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (ネコ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'ネコ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'ネコ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (イヌ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'イヌ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'イヌ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (ウマ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'ウマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'ウマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (ヒツジ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'ヒツジ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'ヒツジ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (ウシ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'ウシ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'ウシ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (ゾウ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'ゾウ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'ゾウ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (クマ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'クマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'クマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (シマウマ)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'シマウマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'シマウマ').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags (キリン)" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/tags/#{Tag.find_by(name: 'キリン').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/tags/#{Tag.find_by(name: 'キリン').id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/tags", "layouts/application"
      end
    end
  end

  describe "GET #tags with wrong-tag" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/tags/wrong-tag"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/posts/tags/wrong-tag"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe "GET #show" do
    before do
      @post = create(:post, user_id: user.id)
    end

    context "before login" do
      it "returns a 200 response" do
        get "/posts/#{@post.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/show", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/#{@post.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/show", "layouts/application"
      end
    end
  end

  describe "GET #show with invalid id" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/123456789"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/123456789"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe "GET #show with wrong id" do
    context "before login" do
      it "returns a 200 response" do
        get "/posts/wrong-id"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/wrong-id"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe "GET #new" do
    context "before login" do
      it "returns a 302 response" do
        get "/posts/new"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
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

  describe "POST #create" do
    context "before login" do
      it "does not change Post counts" do
        expect {
          post "/posts", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        }.to change(Post, :count).by(0)
      end

      it "returns a 302 response" do
        post "/posts", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      before do
        sign_in user
      end

      it "increases Post counts" do
        expect {
          get posts_path
          post "/posts", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        }.to change(Post, :count).by(1)
      end

      it "returns a 302 response" do
        get posts_path
        post "/posts", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "GET #edit" do
    before do
      @post = create(:post, user_id: user.id)
    end

    context "before login" do
      it "returns a 200 response" do
        get "/posts/#{@post.id}/edit"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/posts/#{@post.id}/edit"
        expect(response).to have_http_status 200
        expect(response).to render_template "posts/edit", "layouts/application"
      end
    end
  end

  describe "PATCH #update" do
    before do
      @post = create(:post, user_id: user.id)
    end

    context "before login" do
      it "returns a 302 response" do
        patch "/posts/#{@post.id}", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        patch "/posts/#{@post.id}", params: { post: { comment: "Test Comment.", image: fixture_file_upload("spec/files/cat.jpg") } }, headers: { "content-type": "multipart/form-data" }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/posts/#{@post.id}"
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @post = create(:post, user_id: user.id)
    end

    context "before login" do
      it "does not change Post counts" do
        expect {
          delete "/posts/#{@post.id}"
        }.to change(Post, :count).by(0)
      end

      it "returns a 302 response" do
        delete "/posts/#{@post.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "after login" do
      before do
        sign_in user
      end

      it "decreases Post counts" do
        expect {
          delete "/posts/#{@post.id}"
        }.to change(Post, :count).by(-1)
      end

      it "returns a 302 response" do
        delete "/posts/#{@post.id}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to posts_path
      end
    end
  end
end
