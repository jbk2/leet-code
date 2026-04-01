require './main_jk.rb'
require './journey_calculator.rb'

RSpec.describe JourneyCalculator do
  vehicle_1 = Vehicle.new(id: 1, kwh_capacity: 20, kwh_per_100_km: 10)
  vehicle_2 = Vehicle.new(id: 2, kwh_capacity: 18, kwh_per_100_km: 15)
  route_1 = Route.new(route_id: 1, stops: [{ stop_id: 1, distance_km: 10 },
    { stop_id: 2, distance_km: 20 }])
  route_2 = Route.new(route_id: 2, stops: [{ stop_id: 3, distance_km: 15 },
    { stop_id: 4, distance_km: 25 }])
  vehicles = [vehicle_1, vehicle_2]
  routes = [route_1, route_2]
  
  describe ":routes_total_kms" do
    it "returns total kms of all legs/stops of all given routes" do
      expect(described_class.routes_total_kms(routes)).to be(70)
    end
  end
  describe ":vehicle_routes_rqd_kwh" do
    it "returns total kwh for one vehicle driving all routes" do
      expect(described_class.vehicle_routes_rqd_kwh(vehicle_1, routes)).to eq(7.0)
    end
  end
  describe ":vehicle_journey_consumed_kwh(vehicle, journey)" do
    it "returns correct consumed kwn for single given vehicle and journey" do
      expect(described_class.vehicle_journey_consumed_kwh(vehicle_1, route_1)).to be(3.0)
    end
  end
  describe ":vehicle_can_complete_route_without_recharge?(vehicle, route)" do
    it "returns true or false correctly" do
      route_3 = Route.new(route_id: 2, stops: [{ stop_id: 3, distance_km: 150 },
      { stop_id: 4, distance_km: 150 }])
      expect(described_class.vehicle_can_complete_route_without_recharge?(vehicle_1, route_1)).to be(true)
      expect(described_class.vehicle_can_complete_route_without_recharge?(vehicle_1, route_3)).to be(false)
    end
  end
  describe ":vehicle_route_pairs" do
    it "returns a hash table with vehicle keys paired to route values" do
      table = described_class.vehicle_route_pairs(routes, vehicles)
      correct_output = { vehicle_1 => route_2, vehicle_2 => route_1 }
      expect(table).to eq(correct_output)
    end
  end
  describe ":vehicles_routes_total_kwh" do
    it "correctly sums the kwh consumption up for pairs of vehicles and their routes" do
      pairs = { vehicle_1 => route_2, vehicle_2 => route_1 }
      output = described_class.vehicles_routes_total_kwh(pairs)
      correct_kwh_total = (0.1 * 40) + (0.15 * 30)
      expect(output).to be(correct_kwh_total)
    end
  end
  describe ":sort_routes(routes, direction)" do
    it "returns routes in ascending total distance order" do
      unsorted_routes = [route_1, route_2]
      output = described_class.sort_routes(unsorted_routes, :asc)
      correct_asc_order = [route_1, route_2]
      expect(output).to eq(correct_asc_order)      
    end
    it "returns routes in descending total distance order" do
      unsorted_routes = [route_1, route_2]
      output = described_class.sort_routes(unsorted_routes, :desc)
      correct_desc_order = [route_2, route_1]
      expect(output).to eq(correct_desc_order)      
    end
  end
  describe ":sort_vehicles_by_efficiency(vehicles, direction)" do
    it "returns vehicles in ascending efficiency (i.e. least efficient 1st)" do
      less_efficient_vehicle = Vehicle.new(id: 1, kwh_capacity: 20, kwh_per_100_km: 20)
      more_efficient_vehicle = Vehicle.new(id: 2, kwh_capacity: 20, kwh_per_100_km: 10)
      unsorted_vehicles = [more_efficient_vehicle, less_efficient_vehicle]
      output = described_class.sort_vehicles_by_efficiency(unsorted_vehicles, :asc)
      correct_asc_sorted_vehicles = [less_efficient_vehicle, more_efficient_vehicle]
      expect(output).to eq(correct_asc_sorted_vehicles)
    end
    it "returns vehicles in descending efficienty(i.e. most efficient 1st)" do
      less_efficient_vehicle = Vehicle.new(id: 1, kwh_capacity: 20, kwh_per_100_km: 20)
      more_efficient_vehicle = Vehicle.new(id: 2, kwh_capacity: 20, kwh_per_100_km: 10)
      unsorted_vehicles = [less_efficient_vehicle, more_efficient_vehicle]
      output = described_class.sort_vehicles_by_efficiency(unsorted_vehicles, :desc)
      correct_desc_sorted_vehicles = [more_efficient_vehicle, less_efficient_vehicle]
      expect(output).to eq(correct_desc_sorted_vehicles)
    end
  end
end