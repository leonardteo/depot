class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :order
  
  #Calculate the total price
  def total_price
    return product.price * quantity
  end
  
end
