class AddIndexToFavorites < ActiveRecord::Migration[8.0]
  def change
    add_index :favorites, [:user_id, :job_id], unique: true
  end
end
