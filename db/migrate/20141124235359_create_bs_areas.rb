class CreateBsAreas < ActiveRecord::Migration
  def change
    create_table :bs_areas do |t|
      t.string :name
      t.references :bs_district

      t.timestamps
    end
    add_index :bs_areas, :bs_district_id
  end
end
