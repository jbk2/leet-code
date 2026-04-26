# == Schema Information
#
# Table name: offers
#
#  id                :bigint           not null, primary key
#  price             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  dealer_profile_id :bigint           not null
#  request_id        :bigint           not null
#
# Indexes
#
#  index_offers_on_dealer_profile_id                 (dealer_profile_id)
#  index_offers_on_dealer_profile_id_and_request_id  (dealer_profile_id,request_id) UNIQUE
#  index_offers_on_request_id                        (request_id)
#
# Foreign Keys
#
#  fk_rails_...  (dealer_profile_id => dealer_profiles.id)
#  fk_rails_...  (request_id => requests.id)
#
require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe "attributes" do
    let(:offer) { offers(:dealer_user_one_offer_one) }
    let(:dealer) { dealer_profiles(:dealer_profile_one) }
    let(:request) { requests(:user_one_request_one) }

    it "has :price, :dealer_id, :request_id attributes" do
      expect(offer).to have_attributes(
        price: 1000,
        dealer_profile_id: dealer.id,
        request_id: request.id
      )
    end
  end
end
