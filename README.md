# Events API

This is a simple API built with Ruby on Rails that allows users to manage events, register for events, and view their registrations.

## Features

- User Authentication using Devise

- Events management: create, update, delete events

- Event reservations: register for events and view registrations

- Health check endpoint

## Prerequisites

Before running the application, make sure you have the following installed:

- Ruby 3.x

- Rails 8.x

- PostgreSQL (or your preferred database)


## Setup

1\. Clone the repository

```bash

git clone https://github.com/Mahmoud-Mohamed-3/events_task.git

cd events_task

Install dependencies


bundle install

Set up the database


rails db:create

rails db:migrate

rails db:seed  

Configure your environment variables. Make sure you have the DEVISE_JWT_SECRET_KEY and other necessary credentials set up in your environment.

Start the server


rails server

Your app will now be available at http://localhost:3000.

API Endpoints

Authentication

POST /users/sign_in

Endpoint to log in a user.

Requires email and password.

POST /users

Endpoint to register a new user.

Requires first_name, last_name, email, and password.

Events

GET /api/v1/events

Retrieves a list of all events.

POST /api/v1/events

Creates a new event (requires authentication).

Requires: title, description, date, num_of_attendees.

PUT /api/v1/events/:id

Updates an event by its ID (requires authentication).

Requires: title, description, date, num_of_attendees.

DELETE /api/v1/events/:id

Deletes an event by its ID (requires authentication).

GET /api/v1/event/reservations/:id

Gets a list of reservations for a specific event by event ID.

GET /api/v1/your_events

Retrieves a list of events created by the authenticated user.

Registrations

POST /api/v1/events/:id/register

Registers the user for a specific event (requires authentication).

Requires the event ID.

GET /api/v1/event/registrations/:id

Retrieves the registration information for a specific event and user.

GET /api/v1/your_reservations

Retrieves the list of events the authenticated user is registered for.


Testing

To run the tests for this application, use the following command:


bundle exec rspec

Make sure you have all the required environment variables set up for JWT authentication.


