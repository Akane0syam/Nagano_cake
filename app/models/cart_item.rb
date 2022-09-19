class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def subtotal# 小計を求めるメソッド
    item.with_tax_price * amount
  end
end
