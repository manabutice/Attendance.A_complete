class AddBasicInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :basic_work_time, :datetime
    add_column :users, :designation_work_start_time, :datetime
    add_column :users, :designation_work_end_time, :datetime
  end
end
