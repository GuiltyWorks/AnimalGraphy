require "rails_helper"

RSpec.describe "News", type: :request do
  let(:user) { create(:user) }

  describe "GET #index (key: general)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/general"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/general"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: bird)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/bird"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/bird"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: cat)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/cat"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: dog)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/dog"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/dog"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: horse)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/horse"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/horse"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: sheep)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/sheep"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/sheep"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: cow)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/cow"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/cow"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: elephant)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/elephant"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/elephant"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: bear)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/bear"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/bear"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: zebra)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/zebra"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/zebra"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index (key: giraffe)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/giraffe"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/giraffe"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end
end
