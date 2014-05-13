class CreateSearchTerms < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.string :keywords
      t.string :string
      t.integer :location_id
      t.integer :user_id

      t.timestamps
    end
  end
end
