class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :address
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, default: "job_seeker"
      t.timestamps
    end
  end
end
