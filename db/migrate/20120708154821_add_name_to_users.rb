class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    remove_column :users, :username
    add_index :users, :email, unique: true
  end
end
