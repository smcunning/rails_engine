# Rails Engine

## Table of Contents
- [Overview](#overview)
- [Getting Started](#getting-started)
    - [Ruby & Rails Versions](#ruby-&-rails-versions)
    - [Testing](#testing)
    - [Extras](#extras)
- [Design](#design)
    - [Schema](#schema)
    - [Endpoints](#endpoints)
- [Contributor](#contributor)

***
## Overview
Rails Engine is a REST API which exposes data about merchants, items and revenue. This is a service oriented architecture project completed in the course of six days.

All endpoints return JSON data compliant with the JSON API spec through the use of serializers. Additionally, all endpoints are exposed under an `api` and `v1` namespace, and tested at the request and unit level.

Both Merchants and Items have all CRUD endpoints (`index`, `show`,`create`, `update`, and `destroy`) as well as `find_all` and `find` endpoints which have been namespaced in a SearchController with `index` and `show` functions corresponding to those endpoints. I also explored two relationship endpoints in this project between merchants and items - this is reflected in an endpoint for a specific merchant's items and an endpoint for a specific item's merchant.

Finally, this project utilizes ActiveRecord to complete 4 separate "business intelligence" endpoints which created the necessity for a merchant's revenue controller and a revenue controller outside of either merchants or items namespace.

***

## Getting Started
To get a copy of the project on your local machine for development and testing purposes, first confirm your Ruby and Rails versions, then follow the Local Setup steps below.

### Ruby & Rails Versions

- Ruby 2.5.3
- Rails 5.2.4.3

### Local Setup Instructions

1. Fork and clone this repo into a new directory.
2. CD into `rails_engine`
3. Run `bundle install` to install gem packages
4. Run `rails db:setup` to setup the databases

### Testing
- Run Unit tests: `bundle exec rspec`
- Run through the different endpoints by running your server from the console: `rails s`
    - You can then utilize Postman to delve into all of the endpoints created in this API
    [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/939ae4469e708be62766)
### Extras

**Gems**
- [`rspec-rails`](https://github.com/rspec/rspec-rails) - testing suite
- [`factory-bot`](https://github.com/thoughtbot/factory_bot) - testing object generator
- [`faker`](https://github.com/faker-ruby/faker) - generates fake data for testing
- [`pry`](https://github.com/pry/pry) - runtime developer console
- [`capybara`](https://github.com/teamcapybara/capybara) - aids in application testing and interaction
- [`simplecov`](https://github.com/simplecov-ruby/simplecov) - tracks test coverage
- [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) - simplifies testing syntax
- [`launchy`](https://rubygems.org/gems/launchy/versions/2.5.0) - helper class for launching cross-platform applications
- [`rubocop-rails`](https://github.com/rubocop-hq/rubocop-rails) - enforces Rails best practices and coding conventions
***
## Design
***
### Schema
![schema](https://i.ibb.co/T19TfzR/rails-engine-schema.png)

### Endpoints
***
#### Merchant Endpoints
Merchant resources have full CRUD capabilities through the following endpoints:
- `GET /api/v1/merchants`
- `GET /api/v1/merchants/:id`
- `POST /api/v1/merchants`
- `PATCH /api/v1/merchants/:id`
- `DELETE /api/v1/merchants/:id`

Additionally, Merchants have the following search functionalities:
- `GET /api/v1/merchants/find?{attribute}={value}`
    - finds a single merchant based on query
- `GET /api/v1/merchants/find_all?{attribute}={value}`
    - finds all merchants matching query

#### Item Endpoints
Item resources have full CRUD capabilities through the following endpoints:
- `GET /api/v1/items`
- `GET /api/v1/items/:id`
- `POST /api/v1/items`
- `PATCH /api/v1/items/:id`
- `DELETE /api/v1/items/:id`

Additionally, Items have the following search functionalities:
- `GET /api/v1/items/find?{attribute}={value}`
    - finds a single item based on query
- `GET /api/v1/items/find_all?{attribute}={value}`
    - finds all items matching query

#### Relationship Endpoints
We can explore the relationship between items and merchants through the following endpoints:

-  `GET /api/v1/items/:item_id/merchant
    - returns a merchant that sells the item associated with the id in params
-  `GET /api/v1/merchants/:merchant_id/items
    - returns a list of items sold by the merchant associated with the id in params

#### Business Intelligence Endpoints
The following endpoints require ActiveRecord to analyze and return specified datasets:

- `GET /api/v1/merchants/most_items?quantity={integer}`
    - returns the number of merchants ranked by how many items they have sold in total
- `GET /api/v1/merchants/most_revenue?quantity={integer}`
    - returns the number of merchants ranked by their total revenue
- `GET /api/v1/revenue?start={yyyy-mm-dd}&end={yyyy-mm-dd}`
    - returns total revenue across all merchants for the date range queried
- `GET /api/v1/merchants/:merchant_id/revenue`
    - returns the total revenue for a specific merchant

***

## Contributor
- Shaunda Cunningham (she/her)
  - [GitHub: smcunning](https://github.com/smcunning)
