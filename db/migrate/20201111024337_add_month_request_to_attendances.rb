class AddMonthRequestToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :indicater_check_month, :string
    add_column :attendances, :indicater_reply_month, :string
    add_column :attendances, :change_month, :boolean, default: false
  end
end
