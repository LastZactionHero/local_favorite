class AddSubscriptionToUser < ActiveRecord::Migration
  def up
    add_column :users, :weekly_updates, :boolean, default: true
    add_column :users, :unsubscribe_token, :string

    User.all.each do |user|
      user.send(:set_unsubscribe_token)
      user.save
    end
  end

  def down
    remove_column :users, :weekly_updates, :boolean
    remove_column :users, :unsubscribe_token, :string
  end
end
