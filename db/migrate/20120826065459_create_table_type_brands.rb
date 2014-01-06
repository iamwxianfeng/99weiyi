class CreateTableTypeBrands < ActiveRecord::Migration
  def up
    create_table :type_brands do |t|
      t.integer :type_id
      t.integer :brand_id

      t.timestamps
    end
  end

  def down
    drop_table :type_brands
  end
end
