class AddSportTypeToMountainRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :mountain_routes, :sport_type, :integer, null: false
  end
end
