class AddDeletedAtToImportantModel < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :deleted_at, :integer
    add_column :rooms, :deleted_at, :integer
    add_column :messages, :deleted_at, :integer
  end
end
