class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitude
      t.string :longitude
      t.string :name
      t.integer :radius

      t.timestamps
    end
  end
end
