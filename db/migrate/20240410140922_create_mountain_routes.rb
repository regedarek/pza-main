class CreateMountainRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :mountain_routes, id: :uuid do |t|
      t.date :activity_date
      t.string :area
      t.string :custom_difficulty
      t.boolean :equipped
      t.integer :french_difficulty
      t.integer :length
      t.boolean :multipitch
      t.string :multipitch_difficulty
      t.integer :multipitch_lead
      t.integer :multipitch_number
      t.integer :multipitch_style
      t.string :name
      t.string :partner
      t.string :slug
      t.integer :style
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
