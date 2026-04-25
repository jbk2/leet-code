# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  account_type    :integer          default("vendor"), not null
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_account_type   (account_type)
#  index_users_on_email_address  (email_address) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "password length" do
    it "must be longer than 3 chars" do
      user = User.new(email_address: "test@test.com", password: "ab")
      expect(user).to validate_length_of(:password).is_at_least(3)
    end
  end

  describe "account_type attribute presence" do
    context "dealer account_type users" do
      it "makes :dealer_name and :dealer_score mandatory of :account_type is 'dealer'" do
        dealer_user = User.new(email_address: "test@test.com", password: "password", account_type: "dealer")
        dealer_user.build_dealer_profile(dealer_name: "dealer1")
        dealer_user.save
        expect(dealer_user).to be_valid
        expect(dealer_user.dealer_name).to eq('dealer1')
      end
    end
    context "vendor account_type users" do
      it "do not allow :dealer_name and :dealer_rating attributes" do
        vendor_user = User.new(email_address: "test@test.com", password: "password", account_type: "vendor")
        vendor_user.build_dealer_profile(dealer_name: "dealer1", dealer_rating: 3.5)
        
        expect(vendor_user).not_to be_valid
        expect { vendor_user.save }
          .to change { DealerProfile.count }.by(0)
          .and change { User.count }.by(0)
        expect(vendor_user.errors[:dealer_profile]).to be_present
        expect(vendor_user.dealer_profile).to be_present
        expect(vendor_user.dealer_profile).to be_new_record
      end
    end
  end

  context "dealer users" do
    describe "can access the dealer profile attr values" do
      let(:email) { "test-#{SecureRandom.hex(6)}@test.com" }
      let(:dealer_user) do
        user = User.new(email_address: email, password: "password", account_type: "dealer")
        user.build_dealer_profile(dealer_name: "dealer1")
        user.save
        user
      end
      it ":dealer_name returns the dealer_profile's dealer_name attr" do
        expect(dealer_user.dealer_name).to eq("dealer1")
      end
      it ":dealer_rating returns the dealer_profile's dealer_rating attr" do
        expect(dealer_user.dealer_rating).to eq(5.0)
      end
    end
  end
end
