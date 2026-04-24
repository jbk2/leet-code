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
#
# Indexes
#
#  index_requests_on_state  (state)
#
require 'rails_helper'

RSpec.describe Request, type: :model do
  subject(:request) { described_class.new }
  
  describe "validations" do
    # it "validates presence of make" do
    #   expect(subject).to validate_presence_of(:make)
    # end
    it { is_expected.to validate_presence_of(:make) }
    it { is_expected.to validate_length_of(:make).is_at_least(2).is_at_most(30) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_length_of(:model).is_at_least(2).is_at_most(40) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:mileage) }
    
    it "validates that state can be only open or accepted" do
      expect(subject).to define_enum_for(:state).with_values(open: 0, accepted: 1)
    end

    it "validates year to be between 1900 and current year" do
      expect(subject).to validate_numericality_of(:year).is_in(1900..Time.now.year)
    end
    it "validates mileage to be between 0 and 1,000,000" do
      expect(subject).to validate_numericality_of(:mileage).is_in(0..1000000)
    end
  end
end
