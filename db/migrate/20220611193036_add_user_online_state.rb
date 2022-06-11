class AddUserOnlineState < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :online, :boolean, default: false, null: false
  end
end
