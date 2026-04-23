require 'rails_helper'

RSpec.describe Request, type: :model do
  subject(:request) { described_class.new }
  
  describe "validations" do
    # it { is_expected.to validate_presence_of(:make) }
    it "validates presence of make" do
      expect(subject).to validate_presence_of(:make)
    end
  end
end
