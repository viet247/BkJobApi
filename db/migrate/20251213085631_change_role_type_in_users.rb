class ChangeRoleTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, nil
    execute("update users set role = '1' where role = 'job_seeker' or role IS NULL")
    change_column :users, :role, :integer, using: 'role::integer', default: 1
  end
end
