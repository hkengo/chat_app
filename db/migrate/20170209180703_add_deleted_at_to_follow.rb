class AddDeletedAtToFollow < ActiveRecord::Migration[5.0]
  def change
    add_column :follows, :deleted_at, :integer
    add_column :follows, :is_blocked, :boolean, null: false, default: false
  end
end
