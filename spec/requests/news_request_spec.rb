require "rails_helper"

RSpec.describe "News", type: :request do
  let(:user) { create(:user) }

  before do
    labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt").reject { |label| label.chomp == "other" }
    labels.each do |label|
      create(:tag, name: label.chomp)
    end
  end

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

  describe "GET #index (key: Tag.first.id)" do
    context "before login" do
      it "returns a 200 response" do
        get "/news/#{Tag.first.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/news/#{Tag.first.id}"
        expect(response).to have_http_status 200
        expect(response).to render_template "news/index", "layouts/application"
      end
    end
  end

  describe "GET #index with invalid key" do
    context "before login" do
      it "returns a 302 response" do
        get "/news/#{123456789}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/news/general"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/news/#{123456789}"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/news/general"
      end
    end
  end

  describe "GET #index with wrong key" do
    context "before login" do
      it "returns a 302 response" do
        get "/news/wrong-key"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/news/general"
      end
    end

    context "after login" do
      it "returns a 302 response" do
        sign_in user
        get "/news/wrong-key"
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/news/general"
      end
    end
  end
end
