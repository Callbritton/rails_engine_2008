# README

# Rails Engine

### BE Mod 3 Week 3 Solo Project

## Background and Description

"Rails Engine"/"Rails Driver" is a mock E-Commerce Application that utilizes service-oriented architecture, where the backend (Rails Engine) and the front end (Rails Driver) communicate via APIs. The primary purpose of the project is to expose and format the data (JSON) for the front end to consume.

## Learning Goals

- Expose an API ⭐ ⭐ ⭐
- Use serializers to format JSON responses ⭐ ⭐ ⭐
- Test API exposure ⭐ ⭐ ⭐
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
- Write basic SQL statements without the assistance of an ORM ⭐

## Schema
<img width="769" alt="rails_engine_2008 schema" src="https://user-images.githubusercontent.com/63476564/102561451-c6419b00-40a2-11eb-94de-7ffd667401dd.png">

## Setup

This project utilizes two separate Rails applications:

Both projects require:
- Ruby 2.5.3.
- Rails 5.2.4.3

### Setup Rails Engine:

* Fork this [repository](https://github.com/Callbritton/rails_engine_2008)
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`
    * `rails import`

### Setup Rails Driver

* Clone [Rails Driver](https://github.com/turingschool-examples/rails_driver)
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`
    * `figaro install`
    
* This last command should create the file config/application.yml. Open this file and add configuration for the Environment variable RAILS_ENGINE_DOMAIN. This should be the url from where Rails Engine is being served. Append this to config/application.yml:

`RAILS_ENGINE_DOMAIN: http://localhost:3000`

## Testing

### Test Rails Engine:
* CD into the Rails Engine directory
* Run the test suite with `bundle exec rspec`.

### Test the Spec Harness In Rails Driver:
* Within the Rails Engine app run your development server with `rails s`.
* While the Rails Engine server is running, and in a separate terminal tab (`cmd+t`), CD into the Rails Driver directory.
* Once the Rails Engine server is running, from within the Rails Driver directory run the test suite with `bundle exec rspec`
