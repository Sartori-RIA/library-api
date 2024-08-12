# Library API

* Ruby version 3.2.2
* Ruby on Rails 7.1

* System dependencies
  * Docker
  * Docker Compose

* Configuration
  * `cp .env.example .env` <- to copy the env file
  * `docker compose up --build` <- for the first time
  * `docker compose up -d` <- after the first time

* Database setup
  * `docker exec library_app bundle exec rails db:create`
  * `docker exec library_app bundle exec rails db:migrate`
  * `docker exec library_app bundle exec rails db:seed`
  * `docker exec library_app bundle exec rails db:populate`

* Documentation for the endpoints
  * `http://localhost:3000/apipie`

* HTTP files with examples for the requests
  * `requests/*.http`

* How to run the test suite
  * `docker exec library_app bundle exec rspec`
  * `docker exec library_app bundle exec parallel:spec`

* Services (job queues, cache servers, search engines, etc.)
  * Postgres
  * Sidekiq
    * `http://localhost:3000/sidekiq`
  * OpenSearch
    * `http://localhost:9200`
