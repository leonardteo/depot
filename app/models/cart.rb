#Shopping Cart Data Model
class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  #Add a product to the cart
  def add_product(product_id)
    
    #Check if the current item is in our current line items
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      #If it is already in our line items, increment the quantity
      current_item.quantity += 1
    else
      #Otherwise, build the relationship
      current_item = line_items.build(product_id: product_id)
    end
    
    #return the current item
    current_item
  end
  
  # Calculate the total price
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
end
