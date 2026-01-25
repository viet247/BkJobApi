class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.string :email
      t.string :confirmation_token
      t.datetime :token_sent_at

      t.timestamps
    end
  end
end
