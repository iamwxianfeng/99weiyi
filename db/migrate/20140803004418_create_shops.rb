class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name, limit: 50, default: ''
      t.string :address, default: ''

      t.timestamps
    end
  end
end
