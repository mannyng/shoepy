class CreateCustomers < ActiveRecord::Migration[5.1]
  def up
    create_table :customers do |t|
      t.string :username, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :customer_type, null: false
      t.string :status
      t.integer :user_id, null: false
      t.float   :latitude
      t.float   :longitude
      
      t.timestamps
    end
    add_index "customers",[:city,:state,:status,:username,:latitude,:longitude], name:"CTS-INDEX",using: "btree"
   
  end
  def down
    drop_table :customers
  end
end
