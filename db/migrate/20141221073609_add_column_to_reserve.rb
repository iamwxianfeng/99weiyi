class AddColumnToReserve < ActiveRecord::Migration
  def change
    add_column :reserves, :commented, :boolean, default: false
    add_column :disk_files, :file, :string, limit: 100
  end
end
