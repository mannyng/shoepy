class CreateLineItems < ActiveRecord::Migration[5.1]
  def up
    create_table :line_items do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
  def down
   drop_table :line_items
  end
end
