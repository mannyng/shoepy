class CreateMessages < ActiveRecord::Migration[5.1]
  def up
    create_table :messages do |t|
      t.references :conversation, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.text :msg, null: false
      t.string :sender_name, null: false, unique: true
      
      t.timestamps
    end
    add_index :messages, :sender_name
  end
  def down
    drop_table :messages
  end
end
