class RenameTitleToRoom < ActiveRecord::Migration[5.0]
  def change
    rename_column :rooms, :title, :name
  end
end
