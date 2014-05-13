class AddAutomaticFavoritingToCustomer < ActiveRecord::Migration
  def change
    add_column :users, :automatic_favoriting, :boolean, default: false
  end
end
