require 'json'
require './main_jk.rb'
RSpec.describe "Questions" do
  fleet_json_string = File.read("./vehicles.json")
  fleet_data = JSON.parse(fleet_json_string, symbolize_names: true)
  route_json_string = File.read("./routes.json")
  routes_array = JSON.parse(route_json_string, symbolize_names: true)[:routes]

  fleet = Fleet.new(fleet_data[:vehicles])
  routes = routes_array.map { |route| Route.new(route_id: route[:route_id], stops: route[:stops]) }

  describe "Question 1" do
    it "gives the correct total kwh consumed for least efficient vehicle over all routes" do
      least_efficient_vehicle = fleet.least_efficient_vehicle
      total_kms = JourneyCalculator.routes_total_kms(routes)
      total_energy = JourneyCalculator.vehicle_routes_rqd_kwh(least_efficient_vehicle, routes)
      expect(total_energy).to be(58.8)
    end
  end
  # puts "\e[1;32m#####\e[0m"
  # puts "Total kwh required for the least efficient vehicle: id# \e[1;31m#{least_efficient_vehicle.id}\e[0m
  # to complete the given routes (total routes' kms; \e[1;31m#{total_kms}\e[0m)\nis => \e[1;31m#{total_energy}\e[0m"

  describe "Question 2" do
    it "gives total kwh for each vehicle driving its paired route" do
      route_pairs = JourneyCalculator.vehicle_route_pairs(routes, fleet.vehicles)
      total_kwh = JourneyCalculator.vehicles_routes_total_kwh(route_pairs)
      expect(total_kwh).to be(47.05)
    end
  end
  # total_routes_km = vehicle_route_pairs.values.sum(&:total_distance)
  # total_routes_kwh = vehicle_route_pairs.map { |v, r| JourneyCalculator.vehicle_journey_consumed_kwh(v, r) }.sum

  # puts "\e[1;32m#####\e[0m"
  # puts "total paired routes consumption \e[1;31m#{total_routes_kwh}\e[0m or total kms of \e[1;31m#{total_routes_km}\e[0m"
  # puts "\e[1;32m#####\e[0m"
end
