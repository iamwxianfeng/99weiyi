class AddColumnAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, limit: 50
  end
end
