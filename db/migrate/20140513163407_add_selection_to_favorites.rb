class AddSelectionToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :selection, :string

    Favorite.reset_column_information
    Favorite.update_all({selection: "manual"})
  end
end
