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
  has_many :sessions, dependent: :destroy
  has_many :requests
  has_one :dealer_profile, dependent: :destroy
  enum :account_type, { vendor: 0, dealer: 1 }, default: :vendor
  delegate :dealer_name, :dealer_rating, to: :dealer_profile, allow_nil: true
  accepts_nested_attributes_for :dealer_profile

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates_length_of :password, minimum: 3
  validates :dealer_profile, presence: true, if: :dealer?
  validate :no_dealer_profile_if_vendor

  def no_dealer_profile_if_vendor
    if vendor? && dealer_profile.present?
      errors.add(:dealer_profile, ":dealer_name & :dealer_rating must not be present for vendor accounts")
    end
  end
end
