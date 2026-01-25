class AddPositionIdToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :position_id, :bigint
  end
end
