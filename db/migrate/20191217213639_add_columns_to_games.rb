class AddColumnsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :lat, :float
    add_column :games, :lon, :float
  end
end
