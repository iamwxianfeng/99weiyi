class AddColumnFromUserIdToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :from_user_id, :integer
  end
end
