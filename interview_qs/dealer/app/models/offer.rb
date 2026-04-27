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
class Offer < ApplicationRecord
  belongs_to :dealer_profile
  belongs_to :request
  enum :state, { open: 0, accepted: 1, rejected: 2, withdrawn: 3 }

  validates :request_id, uniqueness: { scope: :dealer_profile_id }
end
