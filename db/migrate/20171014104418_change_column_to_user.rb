class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :name, :string, null: false, unique: true
    change_column :users, :email, :string, null: false, unique: true
    add_index :users, :name
  end
end
