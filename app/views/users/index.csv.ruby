require 'csv'

CSV.generate do |csv|
  csv_column_names =%w(
    Name Email Department Staff_id Card_id 
    Password, Password_confirmation Basic_work_time 
    Designation_work_start_time Designation_work_end_time
  )
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.name,
      user.email,
      user.epartment,
      user.staff_id,
      user.card_id,
      user.password,
      user.password_confirmation,
      user.basic_work_time,
      user.card_id,
      user.designation_work_start_time,
      user.designation_work_end_time,
    ]
    csv << csv_column_values
  end
end
