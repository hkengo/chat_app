class CreateMessages < ActiveRecord::Migration[5.0]
  def up
    create_table :messages do |t|
      t.text :content

      t.timestamps
    end
    change_column :messages, :content, :string, null: false
  end
  
  def down
    drop_table :messages
  end
end
