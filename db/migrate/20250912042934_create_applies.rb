class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.string :resume_url
      t.string :status, null: false
      t.timestamps
    end
  end
end
