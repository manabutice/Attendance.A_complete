class AttendanceChange < ActiveRecord::Migration[5.2]
  # 勤怠編集ページ追加カラム
  def change
    #どの上長に申請しているか
    add_column :attendances, :indicater_check_change, :string
    # 指示者確認の「なし」「承認」「否認」「申請中」を入れるカラム
    add_column :attendances, :indicater_reply_change, :string
  end
end
