class AddSlugToIndustries < ActiveRecord::Migration[6.1]
  def change
    add_column :industries, :slug, :string
    add_index :industries, :slug
  end
end
