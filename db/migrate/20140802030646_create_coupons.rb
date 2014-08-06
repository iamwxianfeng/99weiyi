class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :title, limit: 20, default: ''
      t.decimal :amount, default: 0.0
      t.datetime :end_time, default: '1900-01-01'

      t.timestamps
    end
  end
end
