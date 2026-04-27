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
class DealerProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :offers

  validates_length_of :dealer_name, minimum: 3, maximum: 40
  validates_numericality_of :dealer_rating, less_than_or_equal_to: 10, message: "must be less than or equal to 10"
  validates_numericality_of :dealer_rating, greater_than_or_equal_to: 0, message: "must greater than or equal to 0"
end
