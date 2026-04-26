require 'rails_helper'

RSpec.describe "Offers", type: :request do
  # dont want an offers/new route, only want them made within _request in requests index
  
  # do we want an offers/show view?
  
  let(:dealer_user_one) { dealer_profiles(:dealer_profile_one) }
  let(:offer) { offers(:dealer_user_one_offer_one) }

  def sign_in(user:, password:)
    post session_path, params: { email_address: user.email_address, password: password } 
  end
  describe ":index route only renders if you're a dealer" do
    
  end

  describe ":show route" do
    before do
      sign_in(user: dealer_user_one.user, password: 'password')
      get offer_path(offer)
    end
    it "shows the dealer name that made the offer" do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('dealer1')
    end
    it "shows the price of the offer" do
      # expect(response).to have_http_status(:ok)
      expect(response.body).to include('1000')
    end
    it "shows date and the time that the request was made" do
      # puts response.body.inspect
      expect(response.body).to include(offer.created_at.strftime('%d-%m-%Y, %H:%Mhrs'))
    end
    it "shows the request that the offer was made on" do
      expect(response.body).to include(offer.request.make)
    end

    context "if vendor is viewing" do
      it "enables vendor to accept the offer" do
        # this then creates a jobb doing notification things and changing state of objects etc
      end
    end
  end
end
