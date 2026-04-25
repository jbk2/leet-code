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
  let(:dealer_profile) do
    user = User.new(email_address: "test@test.com", password: "password", account_type: "dealer")
    user.build_dealer_profile(dealer_name: "dealer name", dealer_rating: 3.5)
    user.save!
    user.dealer_profile
  end
  
  context "assocaitions" do
    it "must belong_to a user" do
      subject { is_expected.to belong_to(:user).required }
    end
  end

  context "dealer_name validations" do
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
  
  context "dealer_rating validations" do
    it "must set a default dealer_rating value of 5" do
      dealer_user_default_rating = User.new(email_address: "test@test.com", password: "password", account_type: "dealer")
      dealer_user_default_rating.build_dealer_profile(dealer_name: "dealer name")
      dealer_user_default_rating.save!
      expect(dealer_user_default_rating.dealer_profile.dealer_rating).to eq(5.0)
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


end
