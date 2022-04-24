require "csv"

CSV.generate do |csv|
  column_names = %w(name email affiliation employee_number uid 
    basic_work_time designated_work_start_time designated_work_end_time
    superior admin password )
  csv << column_names
  @users.each do |user|
    column_values = [
      user.name,
      user.email,
      user.affiliation,
      user.employee_number,
      user.uid,
      user.basic_work_time,
      user.designated_work_start_time,
      user.designated_work_end_time,
      user.superior,
      user.admin,
      user.password,
    ]

    csv << column_values
  end
end 