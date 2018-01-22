class CreateCustomerConnects < ActiveRecord::Migration[5.1]
  def up
   #enable_extension "uuid-ossp"
    create_table :customer_connects do |t|
      t.integer :customer_id, null: false
      t.integer :friend_id, null: false
      t.string :subject
      t.text :msg, null: false
      t.string :state

      t.timestamps
    end
     add_index "customer_connects",["customer_id","friend_id"],name: "CUSTOMER_CONNECT",using: :btree
     add_index "customer_connects",["state"],name: "CONNECT_STATE",using: :btree
  end
  def down
    drop_table :customer_connects
  end
end
