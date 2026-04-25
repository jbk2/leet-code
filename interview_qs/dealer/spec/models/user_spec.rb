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
        dealer_user.build_dealer_profile(dealer_name: "dealer1", dealer_rating: 3.5)
        dealer_user.save!
        expect(dealer_user).to be_valid
      end
    end
    context "vendor account_type users" do
      it "do not allow :dealer_name and :ealer_rating attributes" do
        vendor_user = User.new(email_address: "test@test.com", password: "password", account_type: "vendor")
        vendor_user.build_dealer_profile(dealer_name: "dealer1", dealer_rating: 3.5)
        expect(vendor_user).not_to be_valid
      end
    end
  end
end
