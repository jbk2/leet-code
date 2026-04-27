# README

### TODOS
- update all tests to user the created fixtures
- timeout flash display

- *Request expiry*
  - requests expire after 7 days - state moves from 'open' to 'expired'
  - offers only allowed on a open request
    - when request expires:
      - state chage from 'open' to 'expired'
      - any active offers on that request need state changed to 'rejected - expired'
      - scope/filter dealer & vendors requests_path :index views to open requests only
      - provide vendors with a tab in requests_index for expired requests

- *Offer functionality:*
  - _Offer state_
    - offers must have state: [open, accepted, rejected, withdrawn]
      - for dealers
        - filter offers index by state
      - for vendors - do they even have an offers index page? maybe just a requests index page   and top 5 offers listed in requests show?

  - _offer functionality within requests index page_
    - for dealers only
      - shows offer buttons only for dealers
      - shows max offer price and time
    - for vendors
      - shows highest 5 offers
      - shows accept offer button on each offer > routes to an offer show page
  
  - _offer show page:_
    - for dealers:
      - shows offer status accepted / declined / active
      - shows a withdraw off button
    - for vendors
      - shows an accept offer button
      - shows a decline offer button

  - _on offer acceptance:_
    - all other offers from other dealers on the request are rejected
    - alert dealer that maade offer of their success
  
  - _on offer decline:_
    - alert dealer that made offer of their failure
    - change state of offer to declined - not longer shown in offers index 
