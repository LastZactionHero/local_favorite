class CreateBlacklistUsers < ActiveRecord::Migration
  def change
    create_table :blacklist_users do |t|
      t.string :username
      t.integer :user_id

      t.timestamps
    end
  end
end
