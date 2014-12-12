class ChangeReserveStatusType < ActiveRecord::Migration
  def up
    change_column :reserves , :status , :string, limit: 15, default: 'waiting'
  end

  def down
    change_column :reserves , :status , :integer, default: 0
  end
end
