require 'json'
require 'active_support/core_ext/string/inflections'
# Goals: Design a parking lot using object-oriented principles

# Here are a few methods that you should be able to run:
  # Tell us how many spots are remaining
  # Tell us how many total spots are in the parking lot
  # Tell us when the parking lot is full
  # Tell us when the parking lot is empty
  # Tell us when certain spots are full e.g. when all motorcycle spots are taken
  # Tell us how many spots vans are taking up

# Assumptions:
  # The parking lot can hold motorcycles, cars and vans
  # The parking lot has motorcycle spots, car spots and large spots
  # A motorcycle can park in any spot
  # A car can park in a single compact spot, or a regular spot
  # A van can park, but it will take up 3 regular spots
  # These are just a few assumptions. Feel free to ask your interviewer about more assumptions as needed

# vehicle_types = "motorbike" | "car" | "van"
# spot_types = "motorbike" | "car" | "large"
# "van" needs 3 car or large spot types
# "car" can park in a "car" or "large" spot
# "motorbike" can park in any type of spot

class CarPark
  attr_reader :capacity, :parked
  
  PARK_RULES = { motorbike:  {motorbike: 1, car: 1, van: 1}, car: {car: 1, van: 1},
    van: {van: 1, car: 3 } }.freeze

  def initialize(motorbike_spots:, car_spots:, van_spots:)
    @capacity = { motorbike: motorbike_spots, car: car_spots, van: van_spots } 
    @parked = { motorbike: 0, car: 0, van: 0 } 
  end

  def full?
    PARK_RULES.keys.all? { |type| availability(type) == 0 }
  end
  
  def empty?
    PARK_RULES.keys.all? { |type| availability(type) == @capacity[type] }
  end

  def availability(type)
    @capacity[type] - @parked[type]
  end
  
  def parked(type)
    @parked[type]
  end

  def park_vehicle(type)
    # raise ArgumentError, "type undefined #{type}" unless PARK_RULES.key?(type)
    return "type; #{type} undefined" unless PARK_RULES.key?(type)
    rules = PARK_RULES[type]

    rules.each do |space_type, space_count|
      if availability(space_type) >= space_count   
        @parked[space_type] += space_count
        return "parked #{type} successfully in #{space_type}"
      end
    end

    return "no spaces available for #{type}"
  end
end

json = '{"motorbike-spots": 30,"car-spots": 200,"van-spots":20}'
data = JSON.parse(json)
data.transform_keys! { |k| k.underscore.to_sym }
# puts data
london_car_park = CarPark.new(**data)
puts london_car_park.availability(:motorbike)
puts london_car_park.full?
puts london_car_park.park_vehicle(:motorbike)
puts london_car_park.availability(:motorbike)
puts london_car_park.parked(:motorbike)
puts london_car_park.full?
puts london_car_park.empty?
london_car_park.capacity[:van] = 0
puts london_car_park.availability(:car)
puts london_car_park.availability(:van)
puts london_car_park.park_vehicle(:van)
puts london_car_park.availability(:car)
puts london_car_park.availability(:van)
