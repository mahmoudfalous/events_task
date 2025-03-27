class AddremaningSeatsToEvent < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :remaining_seats, :integer, default: 0
  end
end
