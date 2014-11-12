class ChangeUserAutomaticFavoritingToTrue < ActiveRecord::Migration
  def up
    change_column_default(:users, :automatic_favoriting, true)
  end

  def down
    change_column_default(:users, :automatic_favoriting, false)
  end
end
