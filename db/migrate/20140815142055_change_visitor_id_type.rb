class ChangeVisitorIdType < ActiveRecord::Migration
  def up
    change_column :users , :visitor_id , :string, limit: 40
  end

  def down
  end
end
