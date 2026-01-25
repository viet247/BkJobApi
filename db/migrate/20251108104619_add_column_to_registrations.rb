class AddColumnToRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :registrations, :status, :integer, default: 0, null: false
    add_column :registrations, :expires_at, :datetime
  end
end
