module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!, except: [ :index ]
      def index
        @events = Event.all
        render json: { data: @events.each { |event| EventSerializer.new(event) }, status: 200, message: "Events fetched successfully." }
      end

      def create
        @event = current_user.events.build(event_params)
        if @event.save
          render json: { data: EventSerializer.new(@event), status: 200, message: "Event created successfully." }
        else
          render json: { status: 422, message: "Event couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
        end
      end

      def update
        @event = Event.find(params[:id])
        if @event.update(event_params)
          render json: { data: EventSerializer.new(@event), status: 200, message: "Event updated successfully." }
        else
          render json: { status: 422, message: "Event couldn't be updated successfully. #{resource.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
        end
      end

      def destroy
        @event = Event.find(params[:id])
        if @event.destroy
          render json: { status: 200, message: "Event deleted successfully." }
        else
          render json: { status: 422, message: "Event couldn't be deleted successfully. #{resource.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
        end
      end
      def event_reservations
        @event = Event.find(params[:id])
        render json: { data: @event.registrations.each { |registration| RegistrationSerializer.new(registration) }, status: 200, message: "Event reservations fetched successfully." }
      end

      def get_your_events
        @events = current_user.events
        render json: { data: @events.each { |event| EventSerializer.new(event) }, status: 200, message: "Your events fetched successfully." }
      end

      private
      def event_params
        params.require(:event).permit(:title, :description, :date, :num_of_attendees)
      end
    end
  end
end
