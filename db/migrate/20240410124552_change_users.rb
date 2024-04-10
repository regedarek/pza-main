class ChangeUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :last_name_string, :last_name
    add_column :users, :admin, :boolean, default: false
  end
end
