require "rails_helper"

RSpec.describe "Zoo", type: :request do
  let(:user) { create(:user) }

  describe "GET #index" do
    context "before login" do
      it "returns a 200 response" do
        get "/zoo"
        expect(response).to have_http_status 200
        expect(response).to render_template "zoo/index", "layouts/application"
      end
    end

    context "after login" do
      it "returns a 200 response" do
        sign_in user
        get "/zoo"
        expect(response).to have_http_status 200
        expect(response).to render_template "zoo/index", "layouts/application"
      end
    end
  end
end
