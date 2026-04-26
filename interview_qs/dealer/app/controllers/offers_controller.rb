class OffersController < ApplicationController
  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      redirect_to offers_path, notice: "offer successfully created"
    else
      render new_offer_path, status: :unprocessable_entity
    end
  end

  def index
    dealer_profile = Current.user.dealer_profile

    if dealer_profile
      @offers = dealer_profile.offers
    else
      redirect_to requests_path,
        notice: "you're a vendor not a dealer, acct_type: #{Current.user.account_type}"
    end
  end

  def show
    @offer = Offer.find(params[:id])
  end

  private
  def offer_params
    params.expect(offer: [:request_id, :dealer_profile_id, :price])
  end
end
