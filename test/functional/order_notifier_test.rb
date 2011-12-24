require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    
    order = orders(:one)
    
    mail = OrderNotifier.received order
    assert_equal "Order confirmation", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["leonard@ballistiq.com"], mail.from
    assert_match "Dear", mail.body.encoded
  end

  test "shipped" do
    
    order = orders(:one)
    
    mail = OrderNotifier.shipped order
    assert_equal "Order shipped", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["leonard@ballistiq.com"], mail.from

  end

end
