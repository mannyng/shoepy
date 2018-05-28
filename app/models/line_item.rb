class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  #belongs_to :order
  belongs_to :user
  
  def total_price
    Product.price * quantity
  end
  
end
