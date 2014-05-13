class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :search_term_id
      t.text :data

      t.timestamps
    end

    add_index :tweets, :user_id
    add_index :tweets, :search_term_id
  end
end
