class AddUserIdToMessage < ActiveRecord::Migration[5.0]
  def up
    add_column :messages, :user_id, :integer
    change_column :messages, :user_id, :integer, null: false
  end
  
  def down
    remove_column :messages, :user_id
  end
end
