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
class User < ApplicationRecord
  has_secure_password
  has_many :requests
  enum :account_type, { vendor: 0, dealer: 1 }, default: :vendor
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates_length_of :password, minimum: 3
end
