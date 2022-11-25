class Coupon < ApplicationRecord
  belongs_to :orders, optional: true
end
