class RenameUsersColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment, :text
    remove_column :posts, :content, :text
  end
end
