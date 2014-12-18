class AddColumnToDiskFile < ActiveRecord::Migration
  def change
    add_column :disk_files, :mime_type, :string, limit: 20
    add_column :disk_files, :size, :integer
    add_column :disk_files, :file, :string
  end
end
