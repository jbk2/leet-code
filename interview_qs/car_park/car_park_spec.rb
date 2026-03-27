# require 'rspec'
require_relative 'car_park'
require_relative 'car_park_factory'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

RSpec.describe CarPark do
  subject(:car_park) do
    # described_class.new(motorbike_spots: 20, car_spots: 200, van_spots: 20)
    build(:car_park, motorbike_spots: 20, car_spots: 200, van_spots: 20)
  end
  
  describe "#full?" do
    context "with no availability" do
      it "returns false" do
        car_park = build(:car_park)
        20.times do
          car_park.park_vehicle(:motorbike)
          car_park.park_vehicle(:van)
        end
        200.times do
          car_park.park_vehicle(:car)
        end

        expect(car_park.full?).to be(true)
      end
    end
    
    context "with some availability" do
      it "returns false" do
        almost_full_car_park = build(:car_park)
        20.times do
          almost_full_car_park.park_vehicle(:motorbike)
          almost_full_car_park.park_vehicle(:van)
        end
        199.times do
          almost_full_car_park.park_vehicle(:car)
        end

        expect(almost_full_car_park.full?).to be(false)
      end
    end
  end

  describe "#empty?" do
    context "when not empty" do
      it "returns false" do
        car_park.park_vehicle(:motorbike)
        expect(car_park.empty?).to be(false)
      end
    end
    
    context "when empty" do
      it "returns true" do
        expect(car_park.empty?).to be(true)
      end
    end
  end
  
############### Motorbike parking tests ##################
  describe "parking motorbikes" do
    context "with motorbike spots available" do
      it "consumes one motorbike spot" do
        expect { car_park.park_vehicle(:motorbike) }
        .to change{ car_park.availability(:motorbike) }.by(-1)
      end
    end
    
    context "with no motorbike spots but car & van spots" do
      it "consumes one car spot" do
        no_bike_car_park = build(:car_park, motorbike_spots: 0)
        expect { no_bike_car_park.park_vehicle(:motorbike) }
        .to change { no_bike_car_park.availability(:motorbike) }.by(0)
        .and change { no_bike_car_park.availability(:car) }.by(-1)
      end
    end
    
    context "with no motorbike or car spots" do
      it "consumes one van spot" do
        no_bike_or_car_car_park = build(:car_park, motorbike_spots: 0, car_spots: 0)
        expect { no_bike_or_car_car_park.park_vehicle(:motorbike) }
        .to change { no_bike_or_car_car_park.availability(:motorbike) }.by(0)
        .and change { no_bike_or_car_car_park.availability(:car) }.by(0)
        .and change { no_bike_or_car_car_park.availability(:van) }.by(-1)
      end
    end
    
    context "with no spots of any type available" do
      it "doesnt consume any parking spots, but does return 'no availability'" do
        no_availability_car_park = build(:car_park, motorbike_spots: 0, car_spots: 0, van_spots: 0)
        result = nil
        expect {
          result = no_availability_car_park.park_vehicle(:motorbike)
        }.to change { no_availability_car_park.availability(:motorbike) }.by(0)
        .and change { no_availability_car_park.availability(:car) }.by(0)
        .and change { no_availability_car_park.availability(:van) }.by(0)
        expect(result).to eq("no spaces available for motorbike")
      end
    end
  end
  
############### Car parking tests ##################
  describe "parking cars" do
    context "with car spots available" do
      it "consumes one car parking spot" do
        expect { car_park.park_vehicle(:car) }
        .to change { car_park.availability(:car) }.by(-1)
      end
    end
    
    context "with no car spots but some van spots" do
      it "consumes one van spot" do
        no_car_spots = build(:car_park, car_spots: 0)
        expect { no_car_spots.park_vehicle(:car) }
        .to change { no_car_spots.availability(:car) }.by(0)
        .and change {no_car_spots.availability(:motorbike) }.by(0)
        .and change {no_car_spots.availability(:van) }.by(-1)
      end
    end
    context "with no car or van spots it returns no availability" do
      it "doesnt consume any parking spots, but does return 'no availability'" do
        no_car_or_van_spots = build(:car_park, car_spots: 0, van_spots: 0)
        result = nil
        expect {
          result = no_car_or_van_spots.park_vehicle(:car)
        }.to change { no_car_or_van_spots.availability(:car) }.by(0)
        .and change { no_car_or_van_spots.availability(:motorbike) }.by(0)
        .and change { no_car_or_van_spots.availability(:van) }.by(0)
        expect(result).to eq("no spaces available for car")
      end
    end
  end
  
############### Car parking tests ##################
  describe "parking vans" do
    context "with van spots available" do
      it "consumes one van parking spot" do
        expect { car_park.park_vehicle(:van) }
        .to change { car_park.availability(:car) }.by(0)
        .and change { car_park.availability(:motorbike) }.by(0)
        .and change { car_park.availability(:van) }.by(-1)
      end
    end
    context "with no van spots but more than three car spots" do
      it "consumes three car spots" do
        no_van_spots = build(:car_park, van_spots: 0)
        expect { no_van_spots.park_vehicle(:van) }
        .to change { no_van_spots.availability(:car) }.by(-3)
        .and change {no_van_spots.availability(:motorbike) }.by(0)
        .and change {no_van_spots.availability(:van) }.by(0)
      end
    end
    context "with no van spots and less than three car spots" do
      it "is unable to park and returns 'no availability'" do
        no_car_or_van_spots = build(:car_park, car_spots: 0, van_spots: 0)
        result = nil
        expect {
          result = no_car_or_van_spots.park_vehicle(:van)
        }.to change { no_car_or_van_spots.availability(:car) }.by(0)
        .and change { no_car_or_van_spots.availability(:motorbike) }.by(0)
        .and change { no_car_or_van_spots.availability(:van) }.by(0)
        expect(result).to eq("no spaces available for van")
      end
    end
  end
end