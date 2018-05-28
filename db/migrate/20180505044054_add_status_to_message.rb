class AddStatusToMessage < ActiveRecord::Migration[5.1]
  def up
    add_column :messages, :status, :string, default: 'unread'
  end
  def down
    remove_column :message, :status
  end
end
