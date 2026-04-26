# == Schema Information
#
# Table name: dealer_profiles
#
#  id            :bigint           not null, primary key
#  dealer_name   :string
#  dealer_rating :decimal(3, 1)    default(5.0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_dealer_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe DealerProfile, type: :model do
  let(:dealer_profile) { dealer_profiles(:dealer_profile_one) }
  let(:request_one) { requests(:user_one_request_one) }
  let(:request_two) { requests(:user_one_request_two) }
  
  describe "associations" do
    it "must belong_to a user" do
      subject { is_expected.to belong_to(:user).required }
    end
  end

  describe "dealer_name validations" do
    it "a dealer name with less than 3 chars is invalid" do
      dealer_profile.update_attribute("dealer_name", "ab")
      expect(dealer_profile).not_to be_valid
    end
    it "a dealer name with more than 40 chars is invalid" do
      name = 'a' * 41
      dealer_profile.update_attribute("dealer_name", name)
      expect(dealer_profile).not_to be_valid
    end
    it "a dealer name with between 3 and 40 chars is valid" do
      dealer_profile.update_attribute("dealer_name", "dealer name")
      expect(dealer_profile).to be_valid
    end
  end
  
  describe "dealer_rating validations" do
    it "must set a default dealer_rating value of 5" do
      expect(dealer_profile.dealer_rating).to eq(5.0)
    end
    
    it "a dealer_rating of more than >10 is invalid" do
      dealer_profile.update_attribute("dealer_rating", 11)
      expect(dealer_profile).not_to be_valid
    end
    it "a dealer_rating of 10 is valid" do
      dealer_profile.update_attribute("dealer_rating", 10)
      expect(dealer_profile).to be_valid
    end
    it "a dealer_rating of less than 0 is invalid" do
      dealer_profile.update_attribute("dealer_rating", -1)
      expect(dealer_profile).not_to be_valid
    end
    it "a dealer_rating of one decimal place is valid" do
      dealer_profile.update_attribute("dealer_rating", 9.1)
      expect(dealer_profile).to be_valid
    end
    it "more than one decimal place dealer_ratings get rounded to 1 decimal place by the db" do
      dealer_profile.update_attribute("dealer_rating", 9.11)
      expect(dealer_profile.reload.dealer_rating).to eq(9.1)
    end
  end

  describe "dealer offers" do
    it "can create multiple offers for multiple requests" do
      expect {
        dealer_profile.offers.create(price: 1000, request_id: request_two.id)
      }.to change { dealer_profile.offers.count }.by(1)
    end 
    
    it "validates at model level that request_id scoped to dealer_profile_id is unique" do
      dup_offer = Offer.new(price: 1000, request_id: request_one.id,
        dealer_profile_id: dealer_profile.id )
      expect(dup_offer).to be_invalid
    end
  end

end
