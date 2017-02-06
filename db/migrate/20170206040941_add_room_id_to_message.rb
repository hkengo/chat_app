class AddRoomIdToMessage < ActiveRecord::Migration[5.0]
  def up
    add_column :messages, :room_id, :integer
    change_column :messages, :room_id, :integer, null: false
    add_index :messages, :room_id
  end
  
  def down
    remove_column :messages, :room_id
  end
end
