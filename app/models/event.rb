class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  validates :title, :description, :date, :num_of_attendees, presence: true
  validates :num_of_attendees, numericality: { only_integer: true, greater_than: 0 }
  before_create :set_remaining_seats
  before_update :set_remaining_seats

  def set_remaining_seats
    self.remaining_seats = self.num_of_attendees - self.registrations.count
  end
end
