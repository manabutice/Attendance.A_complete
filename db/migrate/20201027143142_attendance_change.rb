class AttendanceChange < ActiveRecord::Migration[5.2]
  # 勤怠編集ページ追加カラム
  def change
    #どの上長に申請しているか
    add_column :attendances, :indicater_check_change, :string
    # 指示者確認の「なし」「承認」「否認」「申請中」を入れるカラム
    add_column :attendances, :indicater_reply_change, :string
    # 変更前時間や編集用の出勤退勤時間
    add_column :attendances, :started_edit_at, :datetime
    add_column :attendances, :started_before_at, :datetime
    add_column :attendances, :finished_before_at, :datetime
    add_column :attendances, :finished_edit_at, :datetime
  end
end
