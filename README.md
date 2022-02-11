# Rails Engine

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

### Rails_Helper 

Add this to the top of your Rails Helper 
``` 
require 'simplecov'
SimpleCov.start
``` 
This should be inside of your RSpec configure block
```
config.include FactoryBot::Syntax::Methods
```

This should be at the botttom of your rails helper 
``` 
Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec

      with.library :rails
    end
  end
```


## Database Creation and Initialization 

The data for this project is included in the repo. You will have to create and migrate the database in order for tests to pass. 

```
rails db:create 
rails db:migrate 
```
