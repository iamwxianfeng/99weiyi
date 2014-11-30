class CreateBsCities < ActiveRecord::Migration
  def change
    create_table :bs_cities do |t|
      t.string :name, limit: 10

      t.timestamps
    end
  end
end
