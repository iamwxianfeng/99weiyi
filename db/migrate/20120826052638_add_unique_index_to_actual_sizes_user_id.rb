class AddUniqueIndexToActualSizesUserId < ActiveRecord::Migration
  def change
    add_index :actual_sizes, :user_id, :unique => true
  end
end
