class AddOvertimeToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :overtime_finished_at, :datetime
    add_column :attendances, :tomorrow, :boolean
    add_column :attendances, :overtime_worked_on, :datetime
    add_column :attendances, :overtime_work, :string
    # 指示者に申請ををしているかを確認するカラム
    add_column :attendances, :indicater_check, :boolean
    # どの上長に残業申請をしているか確認するカラム
    add_column :attendances, :indicater_check_superior, :boolean
  end
end
