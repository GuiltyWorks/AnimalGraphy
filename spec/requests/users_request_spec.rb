require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET #index" do
    context "before login" do
      it "returns a 200 response" do
        get "/users/index"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/users/index"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/index", "layouts/application"
      end
    end
  end

  describe "GET #like" do
    context "before login" do
      it "returns a 200 response" do
        get "/users/#{user.id}/likes"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/likes", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/users/#{user.id}/likes"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/likes", "layouts/application"
      end
    end
  end

  describe "GET #show" do
    context "before login" do
      it "returns a 200 response" do
        get "/users/#{user.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/show", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/users/#{user.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "users/show", "layouts/application"
      end
    end
  end
end
