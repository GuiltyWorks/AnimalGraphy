class RecreateTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :tags
    create_table :tags do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end
  end
end
