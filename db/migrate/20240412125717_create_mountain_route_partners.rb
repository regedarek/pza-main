class CreateMountainRoutePartners < ActiveRecord::Migration[7.1]
  def change
    create_table :mountain_route_partners, id: :uuid do |t|
      t.references :mountain_route, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :mountain_route_partners, [:mountain_route_id, :user_id], unique: true
  end
end
