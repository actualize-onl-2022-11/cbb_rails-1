class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.datetime :scheduled
      t.string :venue
      t.integer :capacity
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :home
      t.string :away

      t.timestamps
    end
  end
end
