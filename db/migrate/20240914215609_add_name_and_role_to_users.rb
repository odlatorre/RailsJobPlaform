class AddNameAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :string
    add_column :users, :role, :string, default: "normal"
  end
end
