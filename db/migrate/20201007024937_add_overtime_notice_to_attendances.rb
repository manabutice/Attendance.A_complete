# 残業申請のお知らせモーダル
class AddOvertimeNoticeToAttendances < ActiveRecord::Migration[5.2]
  def change
    # 指示者確認
    add_column :attendances, :indicater_reply, :integer
    # 変更
    add_column :attendances, :change, :boolean
    # 確認
    add_column :attendances, :verification, :boolean
  end
end
