class CreateTableFiles < ActiveRecord::Migration
  def up
    create_table :files do |t|
      t.integer :user_id
      t.string :digest
      t.string :item_type
      t.integer :item_id

      t.timestamps
    end
    add_index :files, [:item_type,:item_id]
  end

  def down
    drop_table :files
  end
end
