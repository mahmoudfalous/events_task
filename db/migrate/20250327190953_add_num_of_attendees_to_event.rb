class AddNumOfAttendeesToEvent < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :num_of_attendees, :integer, default: 0
  end
end
