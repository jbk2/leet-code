# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  make       :string
#  mileage    :integer
#  model      :string
#  state      :integer          default("open"), not null
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_requests_on_state    (state)
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Request < ApplicationRecord
  enum :state, { open: 0, accepted: 1 }, deafult: :open
  validates_presence_of :make, :model, :year, :mileage, :state
  validates_length_of :make, in: 2..30
  validates_length_of :model, in: 2..40
  validates_numericality_of :year, in: 1900..Time.now.year
  validates_numericality_of :mileage, in: 0..1000000
  validates_inclusion_of :state, in: ['open', 'accepted']
  belongs_to :user
end
