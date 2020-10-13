class AddBasicInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :basic_work_time, :time , default: Time.current.change(hour: 8, min: 0, sec: 0)
    add_column :users, :designation_work_start_time, :time, default: Time.current.change(hour: 9, min: 0, sec: 0)
    add_column :users, :designation_work_end_time, :time, default: Time.current.change(hour: 18, min: 0, sec: 0)
  end
end
