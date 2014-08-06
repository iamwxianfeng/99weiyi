class UserCoupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon

  module Status
    NotUsed = 0 #未使用
    Used    = 1 #已使用
  end

end
