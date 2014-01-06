# encoding:utf-8
class CreateTableUserBrands < ActiveRecord::Migration
  def up
    create_table :user_brands do |t| # 用户的品牌
      t.integer :user_id
      t.integer :type_id
      t.integer :brand_id
      t.integer :model_id
      t.integer :feel_id
      t.string :item # 货号
      t.string :buy_addr # 购买地址

      t.timestamps
    end
  end

  def down
    drop_table :user_brands
  end
end
