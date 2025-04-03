RSpec.describe "Events API", type: :request do
  let(:user) { create(:user) }
  let(:token) do
    JWT.encode(
      { sub: user.id, exp: 7.days.from_now.to_i },
      Rails.application.credentials.devise_jwt_secret_key || ENV['DEVISE_JWT_SECRET_KEY'],
      'HS256'
    )
  end

  let(:headers) { { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" } }

  describe "POST /api/v1/events" do
    it "creates an event" do
      puts "Generated Token: #{token}"

      event_params = { title: "Test Event", description: "An awesome event", date: Time.now }.to_json
      post "/api/v1/events", params: event_params, headers: headers
      puts response.body

      expect(response).to have_http_status(201)
    end
  end
end
