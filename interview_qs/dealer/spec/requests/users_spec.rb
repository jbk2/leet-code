require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  # context "when not logged in" do
    
  # end
  
  # context "when logged in" do
  # end
  
  describe "GET /new" do
    it "returns http success" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /edit" do
    let(:password) { "password" }
    let(:user) { User.create!(email_address: "test@test.com", password: password)}
    it "returns http success" do
      post session_path, params: {email_address: user.email_address, password: password}
      get edit_user_path(user.id)
      expect(response).to have_http_status(:ok)
    end
  end

end
