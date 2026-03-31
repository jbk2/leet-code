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
    @vehicles = parse_vehicles(vehicles)
  end

  def least_efficient_vehicle
    @vehicles.max_by { |vehicle| vehicle.kwh_per_100_km }
  end

  private
  def parse_vehicles(vehicles)
    vehicles_instances = vehicles.map do |vehicle|
      Vehicle.new(id: vehicle[:id], kwh_capacity: vehicle[:capacity_kwh], kwh_per_100_km: vehicle[:kwh_per_100_km])
    end
    vehicles_instances.sort! { |a, b| a.kwh_per_100_km  <=> b.kwh_per_100_km }
  end
end

class Journey
  attr_reader :routes, :vehicle

  def initialize(routes:, vehicle:)
    @routes = sort_routes(routes)
    @vehicle = vehicle
  end

  def total_consumed_energy
    km_sum = @routes.map { |route| route.stops.map { |stop| stop[:km_distance] }.sum }.sum
    @vehicle.consumption_per_km_distance(km_sum)
  end

  private
  def sort_routes(routes)
    routes.sort! { |a, b| b.total_distance <=> a.total_distance }
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
journey = Journey.new(routes: routes, vehicle: least_efficient_vehicle)

puts total_energy = journey.total_consumed_energy

# Question 2 answer

# fleet is already ordered correctly
# ordered_routes = 