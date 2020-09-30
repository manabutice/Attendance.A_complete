class AddOvertimeToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :overtime_finished_at, :datetime
    add_column :attendances, :overtime_worked_on, :datetime
    add_column :attendances, :overtime_work, :string
    add_column :attendances, :indicater_check, :string
  end
end
