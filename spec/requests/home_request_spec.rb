require "rails_helper"

RSpec.describe "Home", type: :request do
  let(:user) { create(:user) }

  describe "GET #about" do
    context "before login" do
      it "returns a 200 response" do
        get about_path
        expect(response).to have_http_status 200
        expect(response).to render_template "home/about", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get about_path
        expect(response).to have_http_status 200
        expect(response).to render_template "home/about", "layouts/application"
      end
    end
  end
end
