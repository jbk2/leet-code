require "./main_jk.rb"

# Compute how much energy (kWh) certain strategies would use, using the supplied JSON files.

RSpec.describe Vehicle do
  subject(:vehicle) do
    described_class.new(id: 1, kwh_capacity: 20, kwh_per_100_km: 10)
  end
  describe "instantiation" do
    it "has :id, a :capacity_kwh, and a :kwh_per_100_km attributes" do
      expect(vehicle).to have_attributes(
        id: 1, kwh_capacity: 20, kwh_per_100_km: 10)
    end
    
    it "has :id, :capacity, and :consumption accessor methods" do
      expect(vehicle.id).to eq(1)
      expect(vehicle.capacity).to eq(20)
      expect(vehicle.consumption).to eq(10)
    end
  end

  describe ":consumption_per_km_distance(distance)" do
    it "returns the vehicles correct kwh consumption for the given distance" do
      expect(vehicle.consumption_per_km_distance(1)).to eq(0.1)
      expect(vehicle.consumption_per_km_distance(100)).to eq(10)
      expect(vehicle.consumption_per_km_distance(250)).to eq(25)
    end
    it "only accepts positive integers as arguments" do
      expect { vehicle.consumption_per_km_distance(-1) }.to raise_error(ArgumentError, "distance must be >= 0")
      # expect(vehicle.consumption_per_km_distance("1")).to eq("given distance must be an integer")
    end
  end
end

RSpec.describe Route do
  subject(:route) do
    described_class.new(route_id: 1,
      stops: [{ stop_id: 12345, distance_km: 10 }, { stop_id: 67890, distance_km: 20 }])
  end

  describe "instantiation" do
    it "has attributes of route_id and stops being an array of stops" do
      expect(route).to have_attributes(route_id: 1, stops: [{ stop_id: 12345, km_distance: 10 }, { stop_id: 67890, km_distance: 20 }])
      expect(route.stops).to be_a(Array)
    end
  end

  describe "a routes stops" do
    it "has a :stops(stop_no) stops accessor method" do
      expect(route.stop_no(1)).to eq({ stop_id: 12345, km_distance: 10 })
    end
    it ":stops(no) with an invalid number returns an error" do
      expect(route.stop_no(3)).to eq("Error: there is no stop number; 3")
      expect(route.stop_no(0)).to eq("Error: there is no stop number; 0")
      expect(route.stop_no(-1)).to eq("Error: there is no stop number; -1")
    end
  end

  describe ":total_distance" do
    it "returns the sum of all stop km_distances" do
      expect(route.total_distance).to eq(30)
    end

  end
end

RSpec.describe Fleet do
  vehicles = [{ "id": "v001", "capacity_kwh": 3, "kwh_per_100_km": 15 },
    { "id": "v006", "capacity_kwh": 7, "kwh_per_100_km": 17 },
    { "id": "v004", "capacity_kwh": 7, "kwh_per_100_km": 17 },
    { "id": "v009", "capacity_kwh": 16, "kwh_per_100_km": 20}]
  
  subject(:fleet) do
    described_class.new(vehicles)
  end

  describe "instantiation" do
    it "has an array of vehicles accessible via :vehicles" do
      expect(fleet.vehicles).to be_a(Array)
    end

    it "has Vehicle objects in its vehicles attribute" do
      first_vehicle = fleet.vehicles.first
      expect(first_vehicle).to be_a(Vehicle)
    end
  end

  describe ":least_efficient_in_fleet" do
    it "returns the least efficient vehicle in the fleet" do
      expect(fleet.least_efficient_vehicle.id).to eq("v009")
    end
  end
end

RSpec.describe Journey do
  vehicle = Vehicle.new(id: 1, kwh_capacity: 20, kwh_per_100_km: 10)
  route = Route.new(route_id: 1, stops: [{ stop_id: 12345, distance_km: 10 },
    { stop_id: 67890, distance_km: 20 }])
  
  subject(:journey) do
    described_class.new(route: route, vehicle: vehicle)
  end

  describe "instantiation" do
    it "has a readable route attribute" do
      expect(journey.route).to eq(route)
    end
    it "has a readable vehicle attribute" do
      expect(journey.vehicle).to eq(vehicle)
    end
  end
  
  describe ":total_consumed_energy" do
    it "give the total kwh consumed for the entire journey" do
      expect(journey.total_consumed_energy).to be(3.0)
    end
  end
end
