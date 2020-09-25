

  CSV.generate(encoding: Encoding::SJIS, write_headers: true, force_quotes: true) do |csv|
    csv_headers = ["日付", "出社", "退社","備考"]
    csv << csv_headers
    @attendances.each do |day|
      values = [
        day.worked_on.strftime('%m/%d'),
        day&.started_at&.strftime('%H:%M'),
        day&.finished_at&.strftime('%H:%M'),
        day.note
      ]

      csv << values
    end   
  end 
