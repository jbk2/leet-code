# 🚗 Dealer Offer Platform – Take-Home Exercise

## 📌 Overview

Build a simplified backend system for a car marketplace.

Customers submit car valuation requests, dealers respond with offers. The system manages offers, enforces business rules, and allows a customer to accept one offer.

This exercise is designed to reflect real-world backend development: domain modeling, business logic, testing, and pragmatic engineering decisions.

---

## 🎯 Objectives
* Model a small but realistic domain
* Implement clear and maintainable business logic
* Demonstrate testing practices
* Make sensible product and engineering decisions

---

## 🧩 Core Requirements

### 1. Customer Requests
Customers can create a **car valuation request**.

Each request should include:

* `make` (e.g. BMW)
* `model` (e.g. 3 Series)
* `year`
* `mileage`

#### Rules

* All fields are required
* Values should be within reasonable ranges (use your judgement)
* A request starts in an `open` state

---

### 2. Dealers

Dealers represent businesses making offers.

Each dealer should have:

* `name`
* `rating` (integer from 1 to 5)

---

### 3. Offers

Dealers can submit offers against a request.

Each offer should include:

* `price`
* `dealer_id`
* `request_id`

#### Rules

* A dealer can only submit **one offer per request**
* Offer price must be greater than 0
* Offers can only be created if the request is in an `open` state

---

### 4. Accepting an Offer

Customers can accept one offer for a request.

#### Rules

* Only one offer can be accepted per request
* When an offer is accepted:

  * The request transitions to `accepted`
  * All other offers for that request are marked as `rejected`
* No further offers can be accepted afterward

---

### 5. Expiry Logic

Requests expire after **7 days**.

#### Rules

* Expired requests cannot accept offers
* You may choose how to implement expiry (e.g. timestamp comparison, background job, etc.)

---

## 🌐 API Expectations

You may design the API as you see fit, but a RESTful approach is recommended.

Example endpoints:

* `POST /requests`
* `GET /requests/:id`
* `POST /offers`
* `POST /offers/:id/accept`

You are free to expand or adjust this.

---

## 🧪 Testing Requirements

Testing is a key part of this exercise.

Include tests that cover:

### Core Logic

* Creating requests
* Creating offers
* Accepting offers

### Edge Cases

* Duplicate offers from the same dealer
* Accepting an offer on an expired request
* Invalid offer price
* Attempting to accept multiple offers

Use any testing framework you prefer (e.g. RSpec, Minitest).

---

## 🧠 Engineering Decisions

You are expected to make and justify decisions such as:

* How to model state (`open`, `accepted`, `expired`)
* Where to place business logic (models, services, etc.)
* How to enforce constraints (validations, database, etc.)

---

## 📄 README Requirements

In your submission, include:

### Setup Instructions

* How to install dependencies
* How to run the app
* How to run tests

### Assumptions

* Any assumptions you made about the domain or requirements

### Trade-offs

* What you chose to simplify or omit and why

### Improvements

* What you would add with more time

---

## ⭐ Optional Enhancements

These are not required but can strengthen your submission.

### Background Processing

* Automatically expire requests (e.g. using a job queue)

### Idempotency

* Prevent duplicate offer submissions
* Handle repeated accept requests safely

### Dealer Ranking

* Determine a “best offer” (e.g. highest price, then highest dealer rating)

### Authentication (Lightweight)

* Distinguish between dealer and customer actions

---

## 🔄 Extensibility

Your solution should be easy to extend.

After submission, you may be asked to:

* Add counter-offers
* Allow dealers to withdraw offers
* Introduce new states or flows

Structure your code accordingly.

---

## ⏱️ Time Expectation

Aim to spend approximately **4–8 hours** on this exercise.

Focus on:

* Core functionality
* Code quality
* Tests
* Clear communication

Avoid over-engineering.

---

## 🧭 Evaluation Criteria

Your submission will be evaluated on:

* Code clarity and structure
* Use of conventions (especially if using Rails)
* Correctness of business logic
* Test coverage and quality
* Simplicity and pragmatism
* Communication via README

---

## 🚀 Getting Started

You are free to choose your stack, but a typical approach might include:

* Ruby on Rails API
* PostgreSQL
* RSpec

---

Good luck — focus on building something clean, thoughtful, and easy to reason about.
