# Events API - Comprehensive Documentation

## Overview

This Ruby on Rails API provides a robust platform for event management, user registration, and event attendance tracking. Built with Rails 8.x and Ruby 3.x, it features JWT authentication, QR code functionality, and a RESTful interface for managing events and registrations.

## Table of Contents

- [System Requirements](#system-requirements)

- [Installation](#installation)

- [Configuration](#configuration)
- [Docker Setup](#docker-setup)
- [API Endpoints](#api-endpoints)
- [Users](#users)
- [Event Management](#event-management)

- [Registration System](#registration-system)

- [QR Code Functionality](#qr-code-functionality)

- [Testing](#testing)

- [Troubleshooting](#troubleshooting)


## System Requirements

- **Ruby** 3.x

- **Rails** 8.x

- **PostgreSQL** 12+ (recommended)

- **Node.js** (for asset compilation)

- **Npm** (for JavaScript dependencies)

## Installation

### Clone the repository
```gitexclude
git clone https://github.com/Mahmoud-Mohamed-3/events_task.git
cd events_task
```

### Install dependencies
```bash
bundle install
```


### Set up the database
```bash
rails db:create

rails db:migrate

rails db:seed
```


## Configuration

### Create a .env file in the project root:


###### **DEVISE_JWT_SECRET_KEY=your_secure_jwt_secret_key_here**

###### **DATABASE_URL=  postgres://username:password@localhost:5432/events_api_development**
## Docker Setup
### Requirements
#### Ensure Docker and Docker Compose are installed on your system. Follow the official documentation for installation:

- Install Docker

- Install Docker Compose

- Running the Project with Docker
##### To build and start the Docker containers:

```gitexclude
docker compose up --build -d
```

**This command will:**

- Build the Docker images (if not already built)

- Start the containers in detached mode (in the background)

**Wait for Database to be Ready**
Before running any commands that interact with the database, ensure the database container is fully initialized. You can check the status by running:
```gitexclude
docker compose ps
```

**Once the database container is healthy, you can proceed.**

**Running Database Migrations and Seeding**
To run the database migrations and seed the database:

- Run migrations:
```gitexclude
docker compose run web bundle exec rails db:migrate
```

- Seed the database:
```gitexclude
docker compose run web bundle exec rails db:seed
```

## API Endpoints

### Users
####  User Registration

```http request
POST http://127.0.0.1:3000/users
Content-Type: application/json

{

"user": {
  "email": "email@example.com",
  "password": "password123",
  "first_name": "John",
  "last_name": "Doe"
 }

}
```

#### User Login

```http request
POST http://127.0.0.1:3000/users/sign_in
Content-Type: application/json

{

"user": {
  "email": "email@example.com",
  "password": "password123"
 }

}
```

#### User Logout

```http request
DELETE http://127.0.0.1:3000/users/sign_out
Authorization: Bearer <your_jwt_token>
```

#### Delete User Account

```http request
DELETE http://127.0.0.1:3000/users
Authorization: Bearer <your_jwt_token>
```


### Event Management

#### List All Events
```http request
GET http://127.0.0.1:3000/api/v1/events
```
#### sample response
```json
{
    "data": [
        {
            "id": 1,
            "title": "Tech Conference",
            "description": "Annual technology conference",
            "date": "2023-12-15T09:00:00.000Z",
            "num_of_attendees": 100,
            "remaining_seats": 20,
            "user_id": 1,
            "created_at": "2022-03-29T14:00:00.000Z",
            "updated_at": "2022-03-29T14:00:00.000Z"
        }
    ]
}
```


#### Create Event

```http request
POST http://127.0.0.1:3000/api/v1/events
Authorization: Bearer <your_jwt_token>
Content-Type: application/json
{
 "event": {
    "title": "Tech Conference",
    "description": "Annual technology conference",
    "date": "2023-12-15T09:00:00Z",
    "num_of_attendees": 100,
    "date": "2023-12-15T09:00:00Z"
}
}
```

#### Update Event

```http request
PUT http://127.0.0.1:3000/events/:id
Authorization: Bearer <your_jwt_token>
Content-Type: application/json

{
"event": {
    "title": "Tech Conference",
    "description": "Annual technology conference",
    "date": "2023-12-15T09:00:00Z",
    "num_of_attendees": 100,
    "date": "2023-12-15T09:00:00Z"
}
}

```

 #### Delete Event

```http request
DELETE http://127.0.0.1:3000/api/v1/events/:id
Authorization: Bearer <your_jwt_token>
```
#### Get Your Event Registrations

```http request
GET http://127.0.0.1:3000/api/v1/event/reservations/:id
```


#### Get Your Events 

```http request
GET http://127.0.0.1:3000/api/v1/your_events
```

### Registration System


#### Register for Event

```http request
POST http://127.0.0.1:3000/api/v1/events/:id/register
Authorization: Bearer <your_jwt_token>
```


#### View An Event Registration
```http request
GET http://127.0.0.1:3000/api/v1/event/registrations/:id
```

#### View Your Registrations

```http request
GET http://127.0.0.1:3000/api/v1/your_reservations
Authorization: Bearer <your_jwt_token>
```


### QR Code Functionality
 Use That Gem to generate QR code for each registration
```gitexclude
gem 'rqrcode'
```

#### key functionality
- Each registration generates a unique QR code
- Stored in active storge 
- Accessible via URL: http://localhost:3000/qrcodes/registration_#{id}.svg
- When scanned, the QR code contains:
  - Event details
  - Attendee information
  - Registration timestamp
  - The URL to view the registration details : http://127.0.0.1:3000/api/v1/event/registrations/:id


## Testing
 ### Run That Command to test the application
```gitexclude
bundle exec rspec
```
### Used Gems for testing
```gitexclude
gem 'rspec-rails'
gem 'factory_bot_rails'
gem 'faker'
```

### Test coverage includes:

- Authentication flows

- Event CRUD operations

- Registration scenarios

- QR code generation



## Troubleshooting

### Common Issues:

 - JWT errors: Verify DEVISE_JWT_SECRET_KEY

- Database issues: Check DATABASE_URL format

- QR codes: Ensure public/qrcodes/ is writable and created

- View Logs:

  - tail -f log/development.log


