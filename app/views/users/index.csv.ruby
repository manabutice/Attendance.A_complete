require "csv"

CSV.generate do |csv|
  column_names = %w(name email department staff_id card_id 
    basic_work_time designation_work_start_time designation_work_end_time
    superior admin password )
  csv << cilumn_names
  @users.each do |user|
    column_values = [
      user.name,
      user.age,
      user.department
      user.staff_id
      user.card_id 
      user.basic_work_time
      user.designation_work_start_time
      user.designation_work_end_time
      user.superior
      user.admin
      user.password
    ]

    csv << column_values
  end
end 