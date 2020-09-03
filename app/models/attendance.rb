class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  validate :finished_at_is_invalid_without_a_started_at
end
