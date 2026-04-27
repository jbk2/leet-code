
class DealerProfilesController < ApplicationController
  def show
    @dealer_profile = DealerProfile.find(params[:id])
  end
end