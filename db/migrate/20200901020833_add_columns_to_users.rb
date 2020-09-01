class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :department, :string
    add_column :users, :staff_id, :string
    add_column :users, :card_id, :string
  end
end
