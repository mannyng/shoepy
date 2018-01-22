class CreateEmployerPosts < ActiveRecord::Migration[5.1]
  def up
    create_table :employer_posts do |t|
      t.string :title
      t.string :description
      t.string :status
      t.integer :customer_id
      
      t.timestamps
    end
  end
  def down
    drop_table :employer_posts
  end
end
