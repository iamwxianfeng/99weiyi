class ChangeColumnWatchersWatchableId < ActiveRecord::Migration
  def up
    change_column :watchers, :watchable_id, :integer
  end

  def down
  end
end
