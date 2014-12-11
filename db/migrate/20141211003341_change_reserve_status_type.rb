class ChangeReserveStatusType < ActiveRecord::Migration
  def up
    change_column :reserves , :status , :string, limit: 15, default: 'waiting'
  end

  def down
  end
end
