class AddColumnInviteCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :invite_code, :string, limit: 15, :default => ''
    add_column :users, :from_user_id, :integer, :default => 0
    add_index :users , :from_user_id
  end
end
