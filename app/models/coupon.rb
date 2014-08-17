# encoding:utf-8

class Coupon < ActiveRecord::Base
  def self.find_or_create_by_amount amount
    @amount = Coupon.find_by_amount(amount) || Coupon.create(title: "30 元优惠券", amount: amount, end_time: '2020-12-31')
    @amount
  end
end
