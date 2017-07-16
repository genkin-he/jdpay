require 'test_helper'

class JdPay::ServiceTest < Minitest::Test
  def setup
    @response_body = <<-EOF
    <?xml version="1.0" encoding="UTF-8"?>
      <jdpay>
        <version>V2.0</version>
        <merchant>22294531</merchant>
        <result>
          <code>000000</code>
          <desc>成功</desc>
        </result>
        <encrypt>N2ZjNmIwMzJiMjA5ZTNhZDhjNjc0YmY1ZWJlY2QyODU0YTc5NmQ3ZWQxMWU1NzE3MWQ0OTUwOGI5NzllYmE4ZjM1YzRiZjlmYWE1M2ZiYjVjYTg5YjA4NTdhMjg3NTBhNzQxM2ZjOWFlN2U3YTNlYzM5ZTI5OTBkZDczNzQ5MjhjM2UxMjhkYWJhMGM0NWY2MWFjYjg2YWFlZDBjOTQ1Y2UyOWNlMDg2MmViOTQ3ZDUyZTczOTMxYjM0NGQwZTNjZGVjZTNkY2EwZmZlYzZlODE1Njc3YWMzODcyNTRhYTcyZDc5MjNhYzc5YWIzZGM0ZGIwYWE4NTc3ZTRhNmE3YmMxMjIwMmEyZmRjMDgxNjhlZjQ5ODVlNGIwNmU2ZTVjZjk3MWRlMmQ5NWYxMmJjNjFiOTY3M2E1ZGY0NWVkNmQ5NzU4OTFmNjFjNTMxMjQ0ZTUyZTdhOWZjNGYwYWRiNTM0ZTQyNGEzMWQyZTYyMWFkMWZkNWY2YTZkZDFmOWNkMTljODg2MzkxNmYwMWViNWMzM2JhNTM5ZWMxYjY1NTA2ZTdmMTYzMjY2YTVjZTk1OTE5M2U0NzNhMGNhMWIwMmVhZjdmYzUyYjc3ZDRiM2Y2NDVlNDFjMDI2YTM0YjU0MGE5MDQzZDEyYmRjNzQzYzM5ODc5NTRhMDcyNGFiOTI4NWQ3MmE0OWUwODNlNGZlNmM3OGMxNGJiNDAzMzI5YTVlMWViNjM2Y2ZkYTg5ZTc1ZDk2ZmJjNTcwMTIyYjU3NWUxZWI2MzZjZmRhODllNzFkYTM0NTE0MDM3YmU5ODQzZTI3Y2Y5OGFjYWM5ZGI3YTg4Yjk5YTQ5NjAxNWYyOWQxZjYwNTJmM2JhOWFlMWI0MzY2Yzc4MmY5YzJlNDY3ODljZjc3ZDMzYjVkN2IyZWRlZjcyOGQ0N2ViZDJkN2Y1YTA5ZTJiYTk5NjUxMGZjNmExMTA3OTFjMjY0NTMyODQ3YjRiYjc3MDlkMmY4YzllY2ZlNzE2MTE1ZjNkMzRlZGRhMmFhOGU4NTA0NThiZTdiOWUzYTM0MDczZTFjNzgxZDFkYzY1ZTRjYzRiYTY3ZGE4NzE4ZjJjNDBmMGU5ZDZlNWU2Y2RiNzAyMzUyNDIyZGVkYmU4NWM4MDdlZTVkNDhkZjg0NGMwNGUwMzA1ZWM5ODJkNmIwMWRmMzg3MjZjZGRkMTVhMWI4YjI1YTdhMWVmNTI2MDUzYmYzYzFlYTBmYmM2MTI3MDMwNTcyNTU1MzQyYjA0ZmZjN2NjOTg4Y2Q2YjQ1M2JhMDQ1NmE3ODUzNDMzMmNmNDFiNWI0M2M5ODhmNmNkMDI2MjFlZDIwYzRhYjliMjU2YmM3ZDU1Yzg2OTBkZWZjNTVhYjA1NzdiYzQxZmY0MzAxNmE3OTRlNWVkMjRjNDc4ZDgzN2JhNDZhMDAwY2ExOGMwMDQ4MWEwMmUyZTcyZjIwYTE0N2MyMTUwMWI3Mjg0NWE0ZDY3YTFiYTEyYzI2MTljYzhkMGM5YzJhOWU1NDljYmY0ZDJlYTM5M2IxYTg5ZWQ4NjMxZWM4NmIwNDI0YzJkYzBjNDU=</encrypt>
      </jdpay>
    EOF
    @result = {"jdpay"=>{"version"=>"V2.0", "merchant"=>"22294531", "result"=>{"code"=>"000000", "desc"=>"成功"}, "orderId"=>"1029148637575787617463", "merchantName"=>"京东支付测试商户号", "amount"=>"1", "expireTime"=>"600", "tradeNum"=>"1486346954111", "qrCode"=>"https://h5pay.jd.com/code?c=616zlks7djfb1z", "sign"=>"C5Mn72q+w1ttkqsUSuhFwJjK8rpikxHkPHaJAXNBVvJGOLMYrSRkHTchACkAISiUzJ60ppWC4DnN6nfnbT5xyrK7kKmHuUivfGRGVnfucvZnV7eDS0Jv+7Np64P/ZyHUkesTDxb0+oDNilTaX82pV5Y2O0qmfs5Ft0LhpJ4Le/w="}}
  end

  def test_uniorder
    stub_request(:post, JdPay::Service::UNIORDER_URL).to_return(body: @response_body)
    params = {
      tradeNum: '123456780',
      tradeName: '测试商品',
      amount: '1',
      orderType: '0',
      notifyUrl: 'http://making.dev/notify'
    }
    assert_equal @result, JdPay::Service.uniorder(params)
  end

  def test_query
    stub_request(:post, JdPay::Service::QUERY_URL).to_return(body: @response_body)
    params = {
      tradeNum: '12345678',
      tradeType: '1',
      oTradeNum: "12345677",
    }
    assert_equal @result, JdPay::Service.query(params)
  end

  def test_refund
    stub_request(:post, JdPay::Service::REFUND_URL).to_return(body: @response_body)
    params = {
      tradeNum: '12345678',
      oTradeNum: "12345677",
      amount: '1',
      notifyUrl: 'http://making.dev/notify',
    }
    assert_equal @result, JdPay::Service.refund(params)
  end

  def test_pc_pay
    html_str = "<html><body onload=document.getElementById('payForm').submit(); style='display: none;'><form action=https://wepay.jd.com/jdpay/saveOrder method='post' id='payForm'><input type='text' name=version value=V2.0><input type='text' name=merchant value=22294531><input type='text' name=tradeTime value=d9668085c69c2ecb73421627b78590400135be4ad908a2a7><input type='text' name=currency value=ac7132c57f10d3ce><input type='text' name=tradeNum value=b9a9953b73f9f8eb3612d06b873f74e9><input type='text' name=tradeName value=25fc4ff3e72f364fc1d80691e88fd7df><input type='text' name=amount value=e5a6c3761ab9ddaf><input type='text' name=orderType value=e00c693e6c5b8a60><input type='text' name=notifyUrl value=d54a8a984359284ec3d58d814e65630300d528555ef1e14ebe9ff87c62d78770><input type='text' name=callbackUrl value=b470f968b7165dcf745e8e129f073434ef9ec43bd64dda9ba2fe77001f4c7347><input type='text' name=userId value=29d899fc35dc7aa50640156c06e5ec0f><input type='text' name=sign value=di/QyXcBJGY/Avb8ilTEUsCxto6F5fbjX4mvGt0a0J2XD1dTJ8sPidfTHofagsgz9H/CP3FC6Hqca49woS7o8vkn4oPfA+coHfxBnm4QtBcvdeQjW3fKq2IKbtGG7UGNGXEJc9Gk7BnXNnuvnbEc5FVFcvbqirdNi+7opO9jmaM=></form></body></html>"
    params = {
      tradeNum: '12345678',
      tradeName: '测试商品',
      amount: '1',
      orderType: '0',
      notifyUrl: 'http://making.dev/notify',
      callbackUrl: 'http://frontend.com/return',
      userId: "0000001",
      tradeTime: '20170718101010'
    }
    assert_equal html_str, JdPay::Service.pc_pay(params)
  end

  def test_h5_pay
    html_str = "<html><body onload=document.getElementById('payForm').submit(); style='display: none;'><form action=https://h5pay.jd.com/jdpay/saveOrder method='post' id='payForm'><input type='text' name=version value=V2.0><input type='text' name=merchant value=22294531><input type='text' name=tradeTime value=d9668085c69c2ecb73421627b78590400135be4ad908a2a7><input type='text' name=currency value=ac7132c57f10d3ce><input type='text' name=tradeNum value=b9a9953b73f9f8eb3612d06b873f74e9><input type='text' name=tradeName value=25fc4ff3e72f364fc1d80691e88fd7df><input type='text' name=amount value=e5a6c3761ab9ddaf><input type='text' name=orderType value=e00c693e6c5b8a60><input type='text' name=notifyUrl value=d54a8a984359284ec3d58d814e65630300d528555ef1e14ebe9ff87c62d78770><input type='text' name=callbackUrl value=b470f968b7165dcf745e8e129f073434ef9ec43bd64dda9ba2fe77001f4c7347><input type='text' name=userId value=29d899fc35dc7aa50640156c06e5ec0f><input type='text' name=sign value=di/QyXcBJGY/Avb8ilTEUsCxto6F5fbjX4mvGt0a0J2XD1dTJ8sPidfTHofagsgz9H/CP3FC6Hqca49woS7o8vkn4oPfA+coHfxBnm4QtBcvdeQjW3fKq2IKbtGG7UGNGXEJc9Gk7BnXNnuvnbEc5FVFcvbqirdNi+7opO9jmaM=></form></body></html>"
    params = {
      tradeNum: '12345678',
      tradeName: '测试商品',
      amount: '1',
      orderType: '0',
      notifyUrl: 'http://making.dev/notify',
      callbackUrl: 'http://frontend.com/return',
      userId: "0000001",
      tradeTime: '20170718101010'
    }
    assert_equal html_str, JdPay::Service.h5_pay(params)
  end

  def test_revoke
    stub_request(:post, JdPay::Service::REVOKE_URL).to_return(body: @response_body)
    params = {
      tradeNum: '12345678',
      oTradeNum: "12345677",
      amount: '1',
    }
    assert_equal @result, JdPay::Service.revoke(params)
  end

  def test_notify_verify
    assert_equal @result, JdPay::Service.notify_verify(@response_body)
  end
end
