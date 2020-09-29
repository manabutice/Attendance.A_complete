class AddOvertimeToAttendaces < ActiveRecord::Migration[5.2]
  def change
    add_column :attendaces, :overtime_finished_at, :datetime
    add_column :attendaces, :overtime_worked_on, :datetime
    add_column :attendaces, :overtime_work, :string
    add_column :attendaces, :indicater_check, :string
  end
end
