module Api
  module V1
    class RegistrationsController < ApplicationController
      before_action :authenticate_user!

      def create
        event = Event.find(params[:id])

        if current_user == event.user
          render json: { status: 422, message: "You can't register for your own event." }, status: :unprocessable_entity
          return
        end

        if event.remaining_seats <= 0
          render json: { status: 422, message: "No remaining seats for this event." }, status: :unprocessable_entity
          return
        end

        registration = event.registrations.create(user: current_user)

        if registration.persisted?
          registration.update_remaining_seats
          # qr_code_url = Rails.application.routes.url_helpers.rails_blob_url(object.qrcode, host: "http://localhost:3000")
          qr_code_url = url_for(registration.qr_code)
          render json: {
            data: {
              qr_code_url: qr_code_url,
              user_id: current_user.id,
              remaining_seats: event.remaining_seats
            },
            message: "Registration Created"
          }, status: :created
        else
          render json: {
            status: 422,
            message: "Registration couldn't be created: #{registration.errors.full_messages.to_sentence}"
          }, status: :unprocessable_entity
        end
      end

      def show
        registration = Registration.find(params[:id])
        if registration
          render json: { data: RegistrationSerializer.new(registration), message: "Registration fetched successfully." }, status: :ok
        else
          render json: { status: 404, message: "Registration not found." }, status: :not_found
        end
      end

      def your_reservations
        registrations = current_user.registrations
        render json: { data: registrations.each { |registration| RegistrationSerializer.new(registration) }, message: "Your reservations fetched successfully." }, status: :ok
      end
    end
  end
end
