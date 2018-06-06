# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

Ruby version

- It uses ruby 2.5.1 version

System dependencies

- Run bundle install

Configuration

- setup Postgresql username and password in .env file

Database creation

- Just run rake db:drop db:create db:migrate

Database initialization

How to run the test suite

Services (job queues, cache servers, search engines, etc.)

Deployment instructions

Test app

### From Postman:

To create content:

- POST http://localhost:3000/contents body: {url: 'http://www.link-to-scrap.com'}
  TO read existing content:
- GET http://localhost:3000/contents
