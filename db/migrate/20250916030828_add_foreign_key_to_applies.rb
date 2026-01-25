class AddForeignKeyToApplies < ActiveRecord::Migration[6.1]
  def change
    add_reference :applies, :job, null: false, foreign_key: true
    add_reference :applies, :user, null: false, foreign_key: true
  end
end
