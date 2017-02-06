class CreateUserRooms < ActiveRecord::Migration[5.0]
  def up
    create_table :user_rooms do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
    add_index :user_rooms, :user_id
    add_index :user_rooms, :room_id
    change_column :user_rooms, :user_id, :integer, null: false
    change_column :user_rooms, :room_id, :integer, null: false
  end
  
  def down
    drop_table :user_rooms
  end
end