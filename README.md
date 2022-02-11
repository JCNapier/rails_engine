# Rails Engin

## Description 

You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume. The organization of this project spec is by feature type.

## Getting Started 

### Ruby Version 
``` 
ruby '2.7.2'
``` 

### Rails Version 
``` 
gem 'rails', '~> 5.2.6'
```

Add the following gems to your gem file in the development/test group:

```
  gem 'simplecov'
  gem 'shoulda-matchers'
``` 
[shoulda-matchers Docs](https://github.com/thoughtbot/shoulda-matchers)
[simplecov](https://github.com/simplecov-ruby/simplecov)

Add the following gems to your gem file in the test group:

``` 
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
```
[faker Docs](https://github.com/faker-ruby/faker)
[factory_bot_rails Docs](https://github.com/thoughtbot/factory_bot_rails)

Add the following gem to your gem file outside of the group do blocks. 

```
gem 'jsonapi-serializer'
```
[jsonapi-serializer Docs](https://github.com/jsonapi-serializer/jsonapi-serializer)

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
