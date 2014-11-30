class CreateFavoritedFollowers < ActiveRecord::Migration
  def change
    create_table :favorited_followers do |t|
      t.string :screen_name
      t.integer :user_id

      t.timestamps
    end
  end
end
