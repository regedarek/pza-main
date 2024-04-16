class AddHiddenToMountainRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :mountain_routes, :hidden, :boolean, null: false, default: false
    change_column_null :mountain_routes, :name, false
    change_column_null :mountain_routes, :slug, false
    change_column_null :mountain_routes, :activity_date, false
  end
end
