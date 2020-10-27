class AddOvertimeToAttendances < ActiveRecord::Migration[5.2]
  # 残業申請モーダル
  def change
    add_column :attendances, :overtime_finished_at, :datetime
    add_column :attendances, :tomorrow, :boolean, default: false
    add_column :attendances, :overtime_work, :string
  # どの上長に残業申請をしているか
    add_column :attendances, :indicater_check, :string
    # 申請した内容を承認したかどうか
    add_column :attendances, :indicater_check_anser, :string
  end
end
