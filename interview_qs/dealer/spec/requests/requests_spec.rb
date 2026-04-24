require 'rails_helper'

RSpec.describe "Requests", type: :request do
  context "when not signed in" do
    describe "GET /requests" do
      it "redirects to sign in" do
        get requests_path
        expect(response).to redirect_to(new_session_path)
      end
    end
    describe "GET /requests/new" do
      it "redirects to sign in" do
        get new_request_path
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "when not signed in" do
    let(:password) { "password" }
    let(:user) { User.create!(email_address: "test@test.com", password: password) }

    def sign_in(user:, password:)
      post session_path, params: { email_address: user.email_address, password: password }
    end
    describe "GET /new" do
      it "returns http success" do
        sign_in(user: user, password: password)
        get new_request_path
        expect(response).to have_http_status(:ok)
      end
    end
    describe "GET /index" do
      it "returns http success" do
        sign_in(user: user, password: password)
        get requests_path
        expect(response).to have_http_status(:success)
      end
    end
    
  end
  


end
