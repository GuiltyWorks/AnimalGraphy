class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :post_id
      t.boolean :bird
      t.boolean :cat
      t.boolean :dog
      t.boolean :horse
      t.boolean :sheep
      t.boolean :cow
      t.boolean :elephant
      t.boolean :bear
      t.boolean :zebra
      t.boolean :giraffe

      t.timestamps
    end
  end
end
