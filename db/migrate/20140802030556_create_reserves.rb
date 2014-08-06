class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.string :address, limit: 100, default: ''
      t.string :name,limit: 20, default: ''
      t.string :phone,limit: 15, default: ''
      t.datetime :service_time, default: '1900-01-01'
      t.integer :store_id, default: 0
      t.integer :reserve_type, default: 0
      t.integer :status, default: 0
      t.integer :user_id, default: 0

      t.timestamps
    end
  end
end
