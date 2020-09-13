class CreateBases < ActiveRecord::Migration[5.2]
  def change
    create_table :bases do |t|
      t.integer :number
      t.string :name
      t.text :information
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
