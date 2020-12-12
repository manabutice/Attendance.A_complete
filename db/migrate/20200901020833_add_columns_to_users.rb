class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :affiliation, :string
    add_column :users, :employee_number, :string
    add_column :users, :uid, :string
  end
end
