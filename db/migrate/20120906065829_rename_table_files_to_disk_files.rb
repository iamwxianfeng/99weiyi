class RenameTableFilesToDiskFiles < ActiveRecord::Migration
  def up
    rename_table :files, :disk_files
  end

  def down
  end
end
