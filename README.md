# Events API - Comprehensive Documentation

## Overview

This Ruby on Rails API provides a robust platform for event management, user registration, and event attendance tracking. Built with Rails 8.x and Ruby 3.x, it features JWT authentication, QR code functionality, and a RESTful interface for managing events and registrations.

## Table of Contents

- [System Requirements](#system-requirements)

- [Installation](#installation)

- [Configuration](#configuration)

- [API Endpoints](#api-endpoints)

- [Authentication](#authentication)

- [Event Management](#event-management)

- [Registration System](#registration-system)

- [QR Code Functionality](#qr-code-functionality)

- [Testing](#testing)

- [Deployment](#deployment)

- [Troubleshooting](#troubleshooting)

- [Contributing](#contributing)

## System Requirements

- **Ruby** 3.x

- **Rails** 8.x

- **PostgreSQL** 12+ (recommended)

- **Node.js** (for asset compilation)

- **Yarn** (for JavaScript dependencies)

## Installation

# Clone the repository

git clone https://github.com/Mahmoud-Mohamed-3/events_task.git

cd events_task

# Install dependencies

bundle install

# Set up the database

rails db:create

rails db:migrate

rails db:seed

Configuration

Create a .env file in the project root:

env

DEVISE_JWT_SECRET_KEY=your_secure_jwt_secret_key_here

DATABASE_URL=postgres://username:password@localhost:5432/events_api_development

RAILS_MAX_THREADS=5

For production, add:

env

API Endpoints

Base URL

Development: http://localhost:3000

All endpoints are versioned under /api/v1/

Authentication

JWT Token System

Include token in requests:

Authorization: Bearer <your_jwt_token>

Endpoints

User Registration

POST /users

Content-Type: application/json

{

  "user": {

    "first_name": "John",

    "last_name": "Doe",

    "email": "john@example.com",

    "password": "securepassword123",

  }

}

User Login

POST /users/sign_in

Content-Type: application/json

{

  "user": {

    "email": "john@example.com",

    "password": "securepassword123"

  }

}

Event Management

Endpoints

List All Events

GET /api/v1/events

Create Event

POST /api/v1/events

Authorization: Bearer <your_jwt_token>

Content-Type: application/json

{

  "event": {

    "title": "Tech Conference",

    "description": "Annual technology conference",

    "date": "2023-12-15T09:00:00Z",

    "num_of_attendees": 100,

    "location": "Convention Center"

  }

}

Update Event

PUT /api/v1/events/:id

Authorization: Bearer <your_jwt_token>

Delete Event

DELETE /api/v1/events/:id

Authorization: Bearer <your_jwt_token>

Registration System

Register for Event

POST /api/v1/events/:id/register

Authorization: Bearer <your_jwt_token>

View Your Registrations

GET /api/v1/your_reservations

Authorization: Bearer <your_jwt_token>

QR Code Functionality

Generated for each registration

Stored in public/qrcodes/

Accessible via URL: http://localhost:3000/qrcodes/registration_1.svg

Contains:

Event details

Attendee information

Registration timestamp

Testing

bundle exec rspec

Test coverage includes:

Authentication flows

Event CRUD operations

Registration scenarios

QR code generation

Troubleshooting

Common Issues:

JWT errors: Verify DEVISE_JWT_SECRET_KEY

Database issues: Check DATABASE_URL format

QR codes: Ensure public/qrcodes/ is writable

View Logs:

tail -f log/development.log

Contributing

Fork the repository

Create a feature branch

Commit your changes

Push to the branch

Open a Pull Request
