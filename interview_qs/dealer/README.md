# README

### TODOS
- update all tests to user the created fixtures
- create offer functionality:



- *enable dealer offers*
  - show offer buttons in requests index view only for dealers
  - create an offer model;
    - dealers have_many offers
    - dealers can only create one offer per request (but they can update that offer)
    - requests have_many offers

_Offer_
* `price`
* `dealer_id`
* `request_id`

belongs_to :dealer_profile
belongs_to :request

request: has_many :offers
dealer_profile has_many :offers