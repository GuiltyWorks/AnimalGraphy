class SetDefaultValueToTags < ActiveRecord::Migration[5.2]
  def change
    change_column :tags, :bird, :boolean, default: false, null: false
    change_column :tags, :cat, :boolean, default: false, null: false
    change_column :tags, :dog, :boolean, default: false, null: false
    change_column :tags, :horse, :boolean, default: false, null: false
    change_column :tags, :sheep, :boolean, default: false, null: false
    change_column :tags, :cow, :boolean, default: false, null: false
    change_column :tags, :elephant, :boolean, default: false, null: false
    change_column :tags, :bear, :boolean, default: false, null: false
    change_column :tags, :zebra, :boolean, default: false, null: false
    change_column :tags, :giraffe, :boolean, default: false, null: false
  end
end
