# == Schema Information
#
# Table name: offers
#
#  id                :bigint           not null, primary key
#  price             :integer          not null
#  state             :integer          default(0), not null
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
#  index_offers_on_state                             (state)
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
    let(:dealer_two) { dealer_profiles(:dealer_profile_two) }
    let(:request) { requests(:user_one_request_one) }
    let(:request_two) { requests(:user_one_request_two) }

    describe "attributes" do
      it "has :price, :dealer_id, :request_id attributes" do
        expect(offer).to have_attributes(
          price: 1000,
          dealer_profile_id: dealer.id,
          request_id: request.id
        )
      end

      it "validates that state can be only :open, :accepted, :rejected or :withdrawn" do
        expect(subject).to define_enum_for(:state).with_values(open: 0,
          accepted: 1, rejected: 2, withdrawn: 3)
      end
    end

    describe "associations" do
      it "belongs_to a dealer" do
        expect(offer.dealer_profile).to eq(dealer)
        expect(offer.dealer_profile).not_to eq(dealer_two)
      end
  
      it "belongs_to a request" do
        expect(offer.request).to eq(request)
        expect(offer.request).not_to eq(request_two)
      end
    end

    describe "offer per request and dealer uniqueness" do
      it "only allows one offer per request enforced by DB" do
        dup_offer = Offer.new(
          price: 1000,
          request_id: request.id,
          dealer_profile_id: dealer.id
        )
        expect {
          dup_offer.save!(validate: false)
        }.to raise_error(ActiveRecord::RecordNotUnique)
      end
      
    end
  end
end
