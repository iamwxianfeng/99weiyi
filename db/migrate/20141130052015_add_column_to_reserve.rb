class AddColumnToReserve < ActiveRecord::Migration
  def change
    add_column :reserves, :height_id, :integer, default: 0
    add_column :reserves, :weight_id, :integer, default: 0
    add_column :reserves, :desc, :string
    add_column :reserves, :tailor_id, :integer
    # remove_column :reserves, :store_id, :integer
  end
end
