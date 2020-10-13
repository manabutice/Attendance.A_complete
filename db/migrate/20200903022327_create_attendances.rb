class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.time :started_at
      t.time :finished_at
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
