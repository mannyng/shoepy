class CreateUsers < ActiveRecord::Migration[5.1]
  
  def up
    #enable_extension "uuid-ossp"
    create_table :users do |t|
  t.string :email,              null: false
  t.string :password_digest,    null: false
  t.string   :confirmation_token
  t.datetime :confirmed_at
  t.datetime :confirmation_sent_at

  t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
