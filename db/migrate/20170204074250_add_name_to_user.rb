class AddNameToUser < ActiveRecord::Migration[5.0]
  # sqliteはデフォルト値がNullのNot Nullなカラムを作れないのでchange_columnで対応
  def up
    add_column :users, :name, :string
    change_column :users, :name, :string, null: false
  end
 
  def down
    remove_column :users, :name
  end
end
