class CreateBsDistricts < ActiveRecord::Migration
  def change
    create_table :bs_districts do |t|
      t.string :name
      t.references :bs_city

      t.timestamps
    end
    add_index :bs_districts, :bs_city_id
  end
end
