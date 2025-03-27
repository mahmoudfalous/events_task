# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Clear existing data
Registration.destroy_all
Event.destroy_all
User.destroy_all

# Create Users
users = []
25.times do
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: 'password123',
    password_confirmation: 'password123',
  )
end

puts "✅ Created #{User.count} users"

# Create Events
events = []
50.times do
  event = Event.create!(
    title: Faker::Lorem.name,
    description: Faker::Lorem.paragraph,
    date: Faker::Date.forward(days: 30),
    num_of_attendees: rand(5..20),
    user: users.sample
  )
  event.update(remaining_seats: event.num_of_attendees)
  events << event
end

puts "✅ Created #{Event.count} events"

# Register Users for Events
users.each do |user|
  event = events.sample
  unless event.user == user # Prevent event owner from registering
    Registration.create!(
      user: user,
      event: event,
      # qr_code: "qrcodes/registration_#{user.id}_#{event.id}.svg"
    )
    event.update(remaining_seats: event.remaining_seats - 1)
  end
end

puts "✅ Created #{Registration.count} registrations"
