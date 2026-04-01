module JourneyCalculator
  def self.routes_total_kms(routes)
    routes.map { |route| route.stops.map { |stop| stop[:km_distance] }.sum }.sum
  end

  def self.vehicle_routes_rqd_kwh(vehicle, routes)
    km_sum = self.routes_total_kms(routes)
    vehicle.consumption_per_km_distance(km_sum)
  end

  def self.vehicle_journey_consumed_kwh(vehicle, journey)
    vehicle.consumption_per_km_distance(journey.total_distance)
  end

  def self.vehicle_can_complete_route_without_recharge?(vehicle, route)
    vehicle.max_kms_per_charge >= route.total_distance
  end

  def self.vehicle_route_pairs(routes, vehicles)
    vehicle_route_pairs = {}
    remaining_routes = self.sort_routes(routes, :desc)
    sorted_vehicles = self.sort_vehicles_by_efficiency(vehicles, :desc) #i.e. most efficient vehicles first

    sorted_vehicles.each do |vehicle|
      feasible_routes = remaining_routes.select do |route|
        JourneyCalculator.vehicle_can_complete_route_without_recharge?(vehicle, route)
      end

      next if feasible_routes.empty?

      max_route = feasible_routes.max_by { |route| route.total_distance }
      vehicle_route_pairs[vehicle] = max_route
      remaining_routes.delete(max_route)
    end

    vehicle_route_pairs
  end

  def self.vehicles_routes_total_kwh(vehicle_route_pairs)
    vehicle_route_pairs.map do |vehicle, r|
      vehicle.consumption_per_km_distance(r.total_distance)
    end.sum.floor(2)
  end
  
  def self.sort_routes(routes, direction)
    sign = direction == :asc ? 1 : -1
    routes.sort { |a, b| sign * (a.total_distance <=> b.total_distance) }
  end
  
  def self.sort_vehicles_by_efficiency(vehicles, direction)
    sign = direction == :asc ? -1 : 1 # asc: means least efficient 1st, :desc opposite
    vehicles.sort { |a, b| sign * (a.kwh_per_100_km <=> b.kwh_per_100_km) }
  end
end