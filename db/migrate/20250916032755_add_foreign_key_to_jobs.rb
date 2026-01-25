class AddForeignKeyToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :industry, null: false, foreign_key: true
    add_reference :jobs, :company, null: false, foreign_key: true
    add_reference :jobs, :city, null: false, foreign_key: true
  end
end
