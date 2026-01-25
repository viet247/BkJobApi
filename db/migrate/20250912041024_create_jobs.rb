class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text   :description
      t.decimal :salary, precision: 10, scale: 2

      t.timestamps
    end
  end
end
