class AddOvertimeToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :overtime_finished_at, :datetime
    add_column :attendances, :tomorrow, :boolean
    add_column :attendances, :overtime_worked_on, :datetime
    add_column :attendances, :overtime_work, :string
  # どの上長に残業申請をしているか確認するカラム
    add_column :attendances, :indicater_check, :string
    # 選択した上長に申請中かどうかを確認するカラム
    add_column :attendances, :indicater_check_superior, :string
  end
end
