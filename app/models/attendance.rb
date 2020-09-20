class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  validate :finished_at_is_invalid_without_a_started_at

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end


    def self.to_csv
      headers = %w(日付 出社 退社)
      csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
        all.each do |row|
          csv << ["column1", "column2", "column3"]
        end
      end
      csv_data.encode(Encoding: :SJIS)   
    end




  
end
