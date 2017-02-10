class AddLatestMessageCreatedAt < ActiveRecord::Migration[5.0]
  def up
    add_column :rooms, :latest_message_created_at, :datetime
    add_index :rooms, :latest_message_created_at
  end
  
  def down
    remove_column :rooms, :latest_message_created_at
  end
end
