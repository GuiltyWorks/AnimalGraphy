class RemoveUsersColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name, :string
    remove_column :users, :email, :string
    remove_column :users, :password_digest, :string
    remove_column :users, :created_at, :datetime
    remove_column :users, :updated_at, :datetime
  end
end
