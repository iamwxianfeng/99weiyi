class AddColumnAvatarSrcToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :avatar_src, :string
  end
end
