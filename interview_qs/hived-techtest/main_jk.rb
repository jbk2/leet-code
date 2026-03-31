require 'json'
class Vehicle  
  def initialize(id:, kwh_capacity:, kwh_per_100_km:)
    @id = id
    @kwh_capacity = kwh_capacity
    @kwh_per_100_km = kwh_per_100_km
  end
  
  attr_reader :id, :kwh_capacity, :kwh_per_100_km
  
  alias capacity :kwh_capacity
  alias consumption :kwh_per_100_km

  def consumption_per_km_distance(kms)
    kms = Float(kms)
  rescue TypeError, ArgumentError
    raise ArgumentError, "distance must be a valid number"
  else
    raise ArgumentError, "distance must be >= 0" if kms.negative?
    (@kwh_per_100_km.to_f / 100) * kms
  end

  def max_kms_per_charge
    @kwh_capacity.to_f / (@kwh_per_100_km.to_f / 100)
  end
end

class Route
  def initialize(route_id:, stops:)
    @route_id = route_id
    @stops = parse_stops(stops)
  end

  attr_reader :route_id, :stops

  def stop_no(no)
    if !(1..stops.length).include?(no)
      return "Error: there is no stop number; #{no}"
    end

    stops[no - 1]
  end

  def total_distance
    @stops.sum { |stop| stop[:km_distance] }
  end

  private
  def parse_stops(stops)
    stops.map { |stop| { stop_id: stop[:stop_id], km_distance: stop[:distance_km]} }
  end
end

class Fleet
  attr_reader :vehicles
  
  def initialize(vehicles)
    @vehicles = parse_and_order_vehicles(vehicles)
  end

  def least_efficient_vehicle
    @vehicles.max_by { |vehicle| vehicle.kwh_per_100_km }
  end

  private
  def parse_and_order_vehicles(vehicles)
    vehicles_instances = vehicles.map do |vehicle|
      Vehicle.new(id: vehicle[:id], kwh_capacity: vehicle[:capacity_kwh], kwh_per_100_km: vehicle[:kwh_per_100_km])
    end
    vehicles_instances.sort! { |a, b| a.kwh_per_100_km  <=> b.kwh_per_100_km }
  end
end

class JourneyCalculator
  attr_reader :routes, :vehicles

  def initialize(routes:, vehicles:)
    @routes = sort_routes(routes)
    @vehicles = sort_vehicles(vehicles)
  end

  def self.routes_total_km(routes)
    routes.map { |route| route.stops.map { |stop| stop[:km_distance] }.sum }.sum
  end

  def self.vehicle_routes_rqd_kwh(vehicle, routes)
    km_sum = self.routes_total_km(routes)
    vehicle.consumption_per_km_distance(km_sum)
  end

  def self.vehicle_journey_consumed_kwh(vehicle, journey)
    vehicle.consumption_per_km_distance(journey.total_distance)
  end

  def self.vehicle_can_complete_route_without_recharge?(vehicle, route)
    vehicle.max_kms_per_charge >= route.total_distance
  end
  
  private
  def sort_routes(routes)
    routes.sort! { |a, b| b.total_distance <=> a.total_distance }
  end
  
  def sort_vehicles(vehicles)
    vehicles.sort! { |a, b| b.kwh_per_100_km <=> a.kwh_per_100_km }
  end
end

fleet_json_string = File.read("./vehicles.json")
fleet_data = JSON.parse(fleet_json_string, symbolize_names: true)
route_json_string = File.read("./routes.json")
routes_array = JSON.parse(route_json_string, symbolize_names: true)[:routes]
fleet = Fleet.new(fleet_data[:vehicles])
routes = routes_array.map { |route| Route.new(route_id: route[:route_id], stops: route[:stops]) }

# Question 1 answer:
least_efficient_vehicle = fleet.least_efficient_vehicle
# journey = JourneyCalculator.new(routes: routes, vehicles: [least_efficient_vehicle])
total_kms = JourneyCalculator.routes_total_km(routes)
total_energy = JourneyCalculator.vehicle_routes_rqd_kwh(least_efficient_vehicle, routes)

puts "\e[1;33m#####\e[0m"
puts "Total kwh required for the least efficient vehicle: id# \e[1;31m#{least_efficient_vehicle.id}\e[0m
to complete the given routes (total routes' kms; \e[1;31m#{total_kms}\e[0m)\nis => \e[1;31m#{total_energy}\e[0m"


# Question 2 answer
vehicle_route_table = {}
journey_calculator = JourneyCalculator.new(routes: routes, vehicles: fleet.vehicles)
remaining_routes = journey_calculator.routes.dup

journey_calculator.vehicles.each do |vehicle|
  feasible_routes = remaining_routes.select do |r|
    JourneyCalculator.vehicle_can_complete_route_without_recharge?(vehicle, r)
  end
  
  next if feasible_routes.empty?

  longest_feasible_route = feasible_routes.max_by(&:total_distance)
  vehicle_route_table[vehicle] = longest_feasible_route
  feasible_routes.delete(longest_feasible_route)
end

total_routes_km = vehicle_route_table.values.sum(&:total_distance)
total_routes_kwh = vehicle_route_table.map do |v, r|
  JourneyCalculator.vehicle_journey_consumed_kwh(v, r)
end.sum

puts "\e[1;33m#####\e[0m"
puts "total paired routes consumption \e[1;31m#{total_routes_kwh}\e[0m or total kms of \e[1;31m#{total_routes_km}\e[0m"
puts "\e[1;33m#####\e[0m"
