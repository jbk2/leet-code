# Fleet energy estimation (tech test)



## Context

You work with a small **electric delivery fleet**. Each **vehicle** has a battery size and energy use per distance. Each **route** is a list of **stops**; each stop includes the **distance in km** for that leg of the journey. Compute how much energy (kWh) certain strategies would use, using the supplied JSON files.

## Data

- **`vehicles.json`** — vehicles with `id`, `capacity_kwh` (battery), and `kwh_per_100_km` (consumption).
- **`routes.json`** — routes with `route_id` and `stops`; each stop has `stop_id` and `distance_km`.

### Definitions

- **Total distance of a route** — sum of all `distance_km` values on that route (one continuous trip).
- **Energy for one vehicle on one route** — `(total_km / 100) × kwh_per_100_km`.
- **Least efficient vehicle** — the vehicle with the **largest** `kwh_per_100_km` (most energy per km).

## Question 1

Assume **one** vehicle performs **all** routes: the **least efficient** vehicle in the fleet. For **every** route, compute the energy that vehicle would need to complete that route. **Output the sum** of those energies (total kWh across all routes).

## Question 2

Assume you may **assign routes to different vehicles** using this **greedy rule**:

1. Order vehicles by **efficiency**: **lowest** `kwh_per_100_km` first (most efficient first).
2. Order routes by **total distance**: **longest** first.
3. Walk through vehicles in that order. For each vehicle, assign the **longest remaining** route that vehicle **can** complete in one charge: `capacity_kwh ≥` energy required for that route on that vehicle. Remove that route from the pool, then continue with the next vehicle.

Compute the **total kWh** if each paired vehicle only drives **its** assigned route (sum of energy per pair).

**Compare** this total to the **Question 1** answer (e.g. print both or state the difference).

## Implementation expectations

- Reference solution uses **Ruby** (`main.rb`); you may use any language for practice.
- Load JSON, model vehicles/routes/stops, implement the formulas and both strategies.
- Add tests as needed (the repo may ship with only a stub spec).

## Dataset note

This snapshot has **9** vehicles and **8** routes. The greedy loop assigns at most one route per vehicle per iteration, so in principle all routes can be covered if feasibility allows.

## Conceptual note

Question 1 is a baseline (“one worst-efficiency truck, every route”). Question 2 is a **greedy assignment** — simple and fast, not necessarily globally optimal over all possible matchings.
