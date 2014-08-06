class CreateUserCoupons < ActiveRecord::Migration
  def change
    create_table :user_coupons do |t|
      t.integer :user_id, default: 0
      t.integer :coupon_id, default: 0
      t.integer :status,default: 0

      t.timestamps
    end
  end
end
