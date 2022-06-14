class DeleteOnlineAddConnectionCounterToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      t.remove :online
      t.integer :connection_counter, null: false, default: 0
    end
  end
end
