# README

## About

This micro app tries to show how to decouple representation and validation from ActiveRecord.

Main goal is to make app structure go beyond MVC scaffold and introduce business logic off the Rails-way.

Main idea was taken from Trailblazer, but implementation took only Representable gem for parsing JSON
and dry-validation gem for type validation.

## Provisioning

1. `docker-compose build` and ☕
2. `docker-compose run runner yarn install` and 🥐
3. `docker-compose run runner ./bin/setup` and 🍌

## Running the app

* `docker-compose up rails`

## Creating a ticket via API

* `curl -d "@spec/fixtures/files/ticket_with_excavator.json" -X POST http://localhost:3000/api/v1/tickets`

## Manage tickets

* open http://localhost:3000/

### Possible improvements

* Use components in views, like Cells or view_component

### Credits:

* Docker stuff was taken from https://github.com/evilmartians/chronicles-gql-martian-library

