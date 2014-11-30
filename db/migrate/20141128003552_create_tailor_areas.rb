class CreateTailorAreas < ActiveRecord::Migration
  def change
    create_table :tailor_areas do |t|
      t.integer :tailor_id
      t.integer :bs_area_id
      t.integer :bs_city_id
      t.integer :bs_district_id

      t.timestamps
    end

    add_index :tailor_areas, :tailor_id
    add_index :tailor_areas, :bs_area_id
  end
end
