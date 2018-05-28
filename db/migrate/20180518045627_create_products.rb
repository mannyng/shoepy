class CreateProducts < ActiveRecord::Migration[5.1]
  def up
    create_table :products, id: false, force: true do |t|
      t.integer  :id, limit: 8, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :image_url, null: false
      t.string :status, :default => "active"
      t.decimal :price, precision: 5, scale: 2
      t.text :avatars, array:true, default: []

      t.timestamps
    end
    execute "ALTER TABLE products ADD PRIMARY KEY (id);"
  end
  def down
    drop_table :products
  end
end