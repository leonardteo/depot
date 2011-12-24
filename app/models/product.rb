# Product Model Class
class Product < ActiveRecord::Base
  
  #Associations
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #Validation Rules
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :allow_blank => true, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'Must be a url for a GIF, JPG or PNG image'
  }
  validates :title, :length => { :minimum => 10, :too_short => "needs to be at least %{count} characters long" }
  
  private
  
  #When destroying a product, make sure that it's not being referenced by a line item
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present');
      return false
    end
  end
  
end
