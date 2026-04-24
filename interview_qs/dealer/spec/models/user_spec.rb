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
end
