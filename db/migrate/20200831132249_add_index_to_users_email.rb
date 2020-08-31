class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    # usersテーブルのemailカラムにインデックスを追加してる
    add_index :users, :email, unique: true 
  end
end
