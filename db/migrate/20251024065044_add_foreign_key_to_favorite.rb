class AddForeignKeyToFavorite < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :favorites, :users, column: :user_id
    add_foreign_key :favorites, :jobs, column: :job_id
  end
end
