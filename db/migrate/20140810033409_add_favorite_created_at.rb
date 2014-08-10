class AddFavoriteCreatedAt < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :created_at]
  end
end
