class Attendance < ApplicationRecord
  belongs_to :user
  # 指示者確認のカラム not：なし、approval：承認, denial：否認, applying：申請中 
  enum indicater_reply: { "なし" => 0, "承認" => 1, "否認" => 2, "申請中" => 4 }
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  # お知らせモーダルバリデーション
  # validate :check_indicater_reply, on: :update_overtime_notice
  

  validate :finished_at_is_invalid_without_a_started_at
  validate :started_at_than_finished_at_fast_if_invalid

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end

  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end

  def check_indicater_reply
    if indicater_reply.present?
      errors.add(:indicater_reply, "申請内容を決定して下さい") if change == "0" || change == "1" && indicater_reply == "申請中"
    end
  end
end
