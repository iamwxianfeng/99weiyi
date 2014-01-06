class CreateTableWatchers < ActiveRecord::Migration
  def up
    create_table :watchers do |t|
      t.integer :user_id
      t.string :watchable_type
      t.string :watchable_id

      t.timestamps
    end
    add_index :watchers, [:watchable_type, :watchable_id]
  end

  def down
  end
end
