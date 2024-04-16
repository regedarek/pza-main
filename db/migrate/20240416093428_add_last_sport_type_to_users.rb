class AddLastSportTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_sport_type, :string
  end
end
