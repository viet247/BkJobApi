class AddColumnsForApplies < ActiveRecord::Migration[6.1]
  def change
    add_column :applies, :full_name, :string
    add_column :applies, :email, :string
  end
end
