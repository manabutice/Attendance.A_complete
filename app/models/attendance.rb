class Attendance < ApplicationRecord
  belongs_to :user
  # 指示者確認のカラム not：なし、approval：承認, denial：否認, applying：申請中 
  enum indicater_reply: { "なし" => 0, "承認" => 1, "否認" => 2, "申請中" => 4 }, _prefix: true
  enum indicater_reply_edit: { "なし" => 0, "承認" => 1, "否認" => 2, "申請中" => 4 }, _prefix: true
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  # お知らせモーダルバリデーション
  # validate :check_indicater_reply, on: :update_overtime_notice
  

  


  # def check_indicater_reply
  #   if indicater_reply.present?
  #     errors.add(:indicater_reply, "申請内容を決定して下さい") if change == "0" || change == "1" && indicater_reply == "申請中"
  #   end
  # end
end
