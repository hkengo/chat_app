class AddParticipantsToRoom < ActiveRecord::Migration[5.0]
  def up
    add_column :rooms, :participants, :integer
    add_index :rooms, :participants
    
    Room.all.find_each do |room|
      room.participants = room.users.count
      room.save!
    end
    change_column :rooms, :participants, :integer, null: false
  end
  
  def down
    remove_column :rooms, :participants
  end
end
