require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:vendor_user) { User.create!( email_address: "vendor@test.com", password: "password", account_type: "vendor") }
  let(:vendor2_user) { User.create!( email_address: "vendor2@test.com", password: "password", account_type: "vendor") }
  let(:dealer_user) do
    dealer = User.new(email_address: "dealer@test.com", password: "password", account_type: "dealer")
    dealer.build_dealer_profile(dealer_name: "dealer1", dealer_rating: 3.5)
    dealer.save!
    dealer
  end
  let(:password) { "password" }

  def sign_in(user:, password:)
    post session_path, params: { email_address: user.email_address, password: password } 
  end
  
  context "as a vendor" do
    context "without any requests" do
      it "routes to new request path" do
        sign_in(user: vendor_user, password: password)
        expect(response).to redirect_to(new_request_path)
      end
    end
    context "with requests" do
      it "routes to requests index path" do
        Request.create!(
          make: "vw",
          model: "polo",
          year: 1990,
          mileage: 900,
          user: vendor_user
        )
        sign_in(user: vendor_user, password: password)
        expect(response).to redirect_to(requests_path)
      end
      
      it "routes to requests index path only showing me my requests" do
        Request.create!(
          make: "vw",
          model: "polo",
          year: 1990,
          mileage: 900,
          user: vendor_user
        )
        Request.create!(
          make: "vw",
          model: "beetle",
          year: 1990,
          mileage: 900,
          user: vendor2_user
        )
          
        sign_in(user: vendor_user, password: password)
        follow_redirect!
        
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("polo")
        expect(response.body).not_to include("beetle")
      end
    end
  end

  context "as a dealer" do
    it "routes to the requests index showing all vendor users' requests" do
      Request.create!(
          make: "vw",
          model: "polo",
          year: 1990,
          mileage: 900,
          user: vendor_user
        )
      Request.create!(
        make: "vw",
        model: "beetle",
        year: 1990,
        mileage: 900,
        user: vendor2_user
      )

      sign_in(user: dealer_user, password: password)
      follow_redirect!
      
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("polo")
      expect(response.body).to include("beetle")
    end
  end
end