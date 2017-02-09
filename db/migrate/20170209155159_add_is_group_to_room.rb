class AddIsGroupToRoom < ActiveRecord::Migration[5.0]
  def up
    add_column :rooms, :is_group, :boolean, null: false, default: false
    Room.all.find_each do |room|
      room.update(is_group: true) if room.participants > 2
    end
  end
  
  def down
    drop_column :rooms, :is_group
  end
end
