class CreateAppSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :app_settings, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :checkbox, default: false, null: false
      t.integer :number
      t.integer :setting_type, default: 0, null: false

      t.timestamps
    end

    add_index :app_settings, :slug, unique: true
  end
end
