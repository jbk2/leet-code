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

    unless dealer_profile
      return redirect_to requests_path,
      notice: "you're a vendor not a dealer, acct_type: #{Current.user.account_type}"
    end

    @offers = dealer_profile.offers
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def destroy
    dealer_profile = Current.user.dealer_profile
    raise ActiveRecord::RecordNotFound unless dealer_profile

    offer = Offer.find(params[:id])
    offer.destroy!

    if dealer_profile.offers.any?
      redirect_to offers_path, notice: "Offer successfully cancelled"
    else
      redirect_to requests_path, notice: "Offer successfully cancelled"
    end
  end

  private
  def offer_params
    params.expect(offer: [:request_id, :dealer_profile_id, :price])
  end
end
