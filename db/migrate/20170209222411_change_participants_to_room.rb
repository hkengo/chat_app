class ChangeParticipantsToRoom < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :participants, :integer, null: false, default: 0
  end
end
