require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  #Load fixtures
  fixtures :products
  
  # test "the truth" do
  #   assert true
  # end
  
  test "product attributes must not be empty" do
    product = Product.new
    
    #all the following should return true
    assert product.invalid? 
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
    
  end
  
  test "product price must be positive" do
    product = Product.new(
      title: "My Book Title",
      description: "yyy",
      image_url: "zzz.jpg"
    )
    product.price = -1
    
    #This should throw an invalid
    assert product.invalid?
    assert product.errors[:price].any?
    
    product.price = 0
    assert product.invalid?
    assert product.errors[:price].any?
    
    product.price = 1
    assert product.valid?
    
  end
  
  #Will attempt to create a new product with image_url
  def new_product(image_url)
    Product.new(
      title: "My book title",
      description: "yyyy",
      price: 1.00,
      image_url: image_url
    )
  end
  
  
  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.JpG http://whatever.com/fred.Jpg  }
    bad = %w{ fred.doc fred.gif/doc fred.whatever }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
    
  end
  
  
  test "product is not valid without a unique title" do
    product = Product.new(
    title: products(:ruby).title,
    description: "yyy",
    price: 1,
    image_url: "fred.gif"
    )
    assert !product.save
    assert product.invalid?
    
  end
  
  
  test "title length should be over 10 chars" do
    product = Product.new(
      title: "12345",
      description: "invalid",
      price: 1.00,
      image_url: "fred.gif"
    )
    assert !product.save
  end
  
  
  
end
