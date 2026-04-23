class Request < ApplicationRecord
  enum :state, { open: 0, accepted: 1 }, deafult: :open
  validates_presence_of :make, :model, :year, :mileage, :state
  validates_length_of :make, in: 2..30
  validates_length_of :model, in: 2..40
  validates_numericality_of :year, in: 1900..Time.now.year
  validates_numericality_of :mileage, in: 0..1000000
  validates_inclusion_of :state, in: ['open', 'accepted']
end
