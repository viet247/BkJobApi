class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :user_id, null: false
      t.bigint :job_id, null: false
      t.timestamps
    end
  end
end
