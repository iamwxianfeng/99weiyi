class AddColumnZongdangToActualSize < ActiveRecord::Migration
  def change
    add_column :actual_sizes, :zongdang, :decimal, :precision => 10 , :scale => 2
  end
end
