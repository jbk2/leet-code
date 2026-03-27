require "factory_bot"

FactoryBot.define do
  factory :car_park, class: "CarPark" do
    skip_create
    motorbike_spots { 20 }
    car_spots { 200 }
    van_spots { 20 }

    initialize_with do
      new(
        motorbike_spots: motorbike_spots,
        car_spots: car_spots,
        van_spots: van_spots
      )
    end
  end
end