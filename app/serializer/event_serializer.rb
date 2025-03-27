class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :date, :num_of_attendees, :remaining_seats
end
