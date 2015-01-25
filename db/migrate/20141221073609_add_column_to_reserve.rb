class AddColumnToReserve < ActiveRecord::Migration
  def change
    add_column :reserves, :commented, :boolean, default: false
    add_column :reserves, :tailor_id, :integer, default: 0
    add_column :disk_files, :name, :string, limit: 100
    # alter table reserves add column tailor_id int default 0 ;
  end
end
