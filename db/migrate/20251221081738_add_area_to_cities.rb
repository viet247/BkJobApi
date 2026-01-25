class AddAreaToCities < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :area, :string
  end
end
