require 'rails_helper'

RSpec.describe "Offers", type: :request do
  # dont want an offers/new route, only want them made within _request in requests index
  
  # do we want an offers/show view?
  
  let(:dealer_user_one) { dealer_profiles(:dealer_profile_one) }
  let(:vendor_user_one) { users(:vendor_user_one) }
  let(:offer) { offers(:dealer_user_one_offer_one) }

  def sign_in(user:, password:)
    post session_path, params: { email_address: user.email_address, password: password } 
  end

  context "as a dealer" do
    describe ":show offer route" do
      before do
        sign_in(user: dealer_user_one.user, password: 'password')
        get offer_path(offer)
      end

      it "shows correct details of the request that the offer was made on" do
        expect(response.body).to include(offer.request.make)
        expect(response.body).to include(offer.request.model)
        expect(response.body).to include(offer.request.mileage.to_s)
        expect(response.body).to include(offer.request.year.to_s)
        expect(response.body).to include(offer.created_at.strftime('%d-%m-%Y, %H:%Mhrs'))
      end
      it "does not show the offering dealer name" do
        expect(response).to have_http_status(:ok)
        expect(response.body).not_to include('dealer1')
      end
      
      it "shows a link to click on the public profile of the requester" do
        expect(response.body).to include(user_path(offer.request.user)) 
      end
      it "shows a button to allow the dealer to cancel their offer" do
        expect(response.body).to include('Cancel offer') 
        expect(response.body).to include(%(name="_method" value="delete"))
      end
    end
    
    describe "offers_path, :index" do
      before do
        sign_in(user: dealer_user_one.user, password: 'password')
        get offer_path(offer)
      end

      it "is reachable" do
        get offers_path
        expect(response).to have_http_status(:ok)
      end

      it "links to each offers :show view" do
        expect(response.body).to include(offer_path(offer))
      end
    end
  end
    
  context "as a vendor" do
    describe "offer_path, :show" do
      before do
        sign_in(user: vendor_user_one, password: 'password')
        get offer_path(offer)
      end

      it "shows correct details of the request that the offer was made on" do
        expect(response.body).to include(offer.request.make)
        expect(response.body).to include(offer.request.model)
        expect(response.body).to include(offer.request.mileage.to_s)
        expect(response.body).to include(offer.request.year.to_s)
        expect(response.body).to include(offer.created_at.strftime('%d-%m-%Y, %H:%Mhrs'))
      end
      it "does show the offering dealer name" do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('dealer1')
      end
      it "shows a link to click on the public profile of the offering dealer" do
        expect(response.body).to include(dealer_profile_path(dealer_user_one))
      end
      xit "shows a button to allow the vendor to accept the offer" do
        expect(response.body).to include('Accept offer')
        expect(response.body).to include(accept_offer_path(offer))
      end
    end

    describe "offers_path, :index" do
      before do
        sign_in(user: vendor_user_one, password: 'password')
        get offer_path(offer)
      end

      it "is unreachable" do
        get offers_path
        expect(response).to have_http_status(302)
      end
    end
  end
end
