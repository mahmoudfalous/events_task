require "rqrcode"

class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, uniqueness: { scope: :event_id, message: "You have already registered for this event." }

  after_create :generate_qr,  :update_remaining_seats
  def generate_qr
    qr = RQRCode::QRCode.new("http://127.0.0.1:3000/api/v1/event/registrations#{id}")
    qr_svg = qr.as_svg(module_size: 6)

    file_path = Rails.root.join("public/qrcodes/registration_#{id}.svg")
    File.write(file_path, qr_svg)

    "/qrcodes/registration_#{id}.svg"
  end
  def update_remaining_seats
    event.decrement!(:remaining_seats) if event.remaining_seats > 0
  end
end
