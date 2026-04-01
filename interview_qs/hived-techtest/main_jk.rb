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