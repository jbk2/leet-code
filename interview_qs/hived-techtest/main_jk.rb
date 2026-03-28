class Vehicle  
  def initialize(id:, kwh_capacity:, kwh_per_100_km:)
    @id = id
    @kwh_capacity = kwh_capacity
    @kwh_per_100_km = kwh_per_100_km
  end
  
  attr_reader :id, :kwh_capacity, :kwh_per_100_km
  
  alias capacity :kwh_capacity
  alias consumption :kwh_per_100_km
end

class Route
  def initialize(route_id:, stops:)
    @route_id = route_id
    @stops = stops
  end

  attr_reader :route_id, :stops

  def stop_no(no)
    if !(1..stops.length).include?(no)
      return "Error: there is no stop number; #{no}"
    end

    stops[no - 1]
  end
end