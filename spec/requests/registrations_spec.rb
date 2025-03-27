require 'rails_helper'

RSpec.describe "Registrations API", type: :request do
  let!(:user) { create(:user) }
  let!(:event) { create(:event, user: create(:user)) } # Event by another user
  let!(:registration) { create(:registration, user: user, event: event) }
  let(:headers) { { "Authorization" => "Bearer #{user.jti}" } }

  describe "POST /api/v1/events/:id/register" do
    it "registers a user for an event" do
      post "/api/v1/events/#{event.id}/register", headers: headers

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)["message"]).to eq("Registration Created")
    end
  end

  describe "GET /api/v1/your_reservations" do
    it "returns the user's registrations" do
      get "/api/v1/your_reservations", headers: headers

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
