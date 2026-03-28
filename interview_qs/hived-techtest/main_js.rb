require 'json'

class Vehicle
  def initialize(id:, capacity_kwh:, kwh_per_100_km:)
    @id = id
    @capacity_kwh = capacity_kwh
    @kwh_per_100_km = kwh_per_100_km
  end

  attr_accessor :id, :capacity_kwh, :kwh_per_100_km
end

class Route
  def initialize(route_id:)
    @route_id = route_id
  end

  attr_accessor :route_id, :stops
end

class Stop
  def initialize(stop_id:, distance_km:)
    @stop_id = stop_id
    @distance_km = distance_km
  end

  attr_accessor :stop_id, :distance_km
end

def get_vehicles
  file = File.open './vehicles.json'
  data = JSON.load file

  vehicles = []

  vehicle_dat = data['vehicles']
  vehicle_dat.each do |vd|
    vehicle = Vehicle.new(id: vd['id'], capacity_kwh: vd['capacity_kwh'], kwh_per_100_km: vd['kwh_per_100_km'])
    vehicles << vehicle
  end

  vehicles
end

def get_routes
  file = File.open './routes.json'
  data = JSON.load file

  routes = []

  route_dat = data['routes']
  route_dat.each do |rd|
    route = Route.new(route_id: rd['route_id'])

    stop_data = rd['stops']
    stops = get_stops(stop_data)
    route.stops = stops

    routes << route
  end

  routes
end

def get_stops(dat)
  stops = []

  dat.each do |d|
    stop = Stop.new(stop_id: d['stop_id'], distance_km: d['distance_km'])
    stops << stop
  end

  stops
end

def energy_for_route(vehicle, route)
  dist = get_total_distance(route)
  (dist / 100) * vehicle.kwh_per_100_km
end

def get_total_distance(route)
  tot = 0

  route.stops.each do |stop|
    tot += stop.distance_km
  end

  tot
end

def get_least_efficient_vehicle(vehicles)
  vehicles.sort_by! { it.kwh_per_100_km }
  vehicles.last
end

def vehicle_can_cover_route?(vehicle, route)
  energy_needed = energy_for_route(vehicle, route)
  vehicle.capacity_kwh >= energy_needed
end

def q1
  vehicles = get_vehicles
  routes = get_routes

  least_efficient = get_least_efficient_vehicle(vehicles)
  total_energy_kwh = 0
  routes.each do |route|
    total_energy_kwh += energy_for_route(least_efficient, route)
  end

  total_energy_kwh
end

def q2
  vehicles_by_efficiency = get_vehicles.sort_by! { it.kwh_per_100_km }
  routes_by_length = get_routes.sort_by! { get_total_distance(it) }.reverse!

  vehicle_routes = []

  vehicles_by_efficiency.each do |vehicle|
    routes_by_length.each do |route|
      next unless vehicle_can_cover_route?(vehicle, route)

      vehicle_routes << { vehicle: vehicle, route: route }
      routes_by_length.delete(route)
      break
    end
  end

  # get total energy consumed using route pairing
  # get q1 answer
  # compare

  total_energy_optimised = 0
  vehicle_routes.each do |vehicle_route|
    total_energy_optimised += energy_for_route(vehicle_route[:vehicle], vehicle_route[:route])
  end

  q1_answer = q1
  puts "Q1: #{q1_answer}"
  puts "optimised: #{total_energy_optimised}"
end

q2
