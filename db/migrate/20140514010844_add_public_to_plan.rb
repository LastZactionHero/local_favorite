class AddPublicToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :public, :boolean
    add_column :plans, :automatic_favoriting_enabled, :boolean
    add_column :plans, :max_search_terms, :integer
    add_column :plans, :max_favorites_per_day, :integer
  end
end
