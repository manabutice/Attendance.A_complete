class AddOvertimesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :overtime_finished_at, :datetime
    add_column :users, :overtime_worked_on, :datetime
    add_column :users, :overtime_work, :string
    add_column :users, :indicater_check, :string
  end
end
