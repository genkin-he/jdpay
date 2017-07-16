require 'test_helper'

class JdPay::SignTest < Minitest::Test
  def test_rsa_decrypt
    xml_str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><jdpay><version>V2.0</version><merchant>22294531</merchant><result><code>000000</code><desc>成功</desc></result><tradeNum>1494236491939_r</tradeNum><oTradeNum>1494236491939</oTradeNum><amount>1</amount><currency>CNY</currency><tradeTime>20170508180239</tradeTime><note></note><status>1</status></jdpay>"
    sign =  "W4g4PwHlh7OM60uz72MYH4+5PW1lJyFoHiKGFczOGDHdATqAAqbRy4p+sXU04FlsA29UpEfY3Fsct1IAhL5D7y1/tgZDRB+tGe1Tm0zTeFcKQjV8UU7bfRC+Mi3OdQgQvJ2JIIJcsxpXyQmeG2Vr/77aPhCY8hNEQObDp8fDDFc="
    assert_equal Digest::SHA256.hexdigest(xml_str), JdPay::Sign.rsa_decrypt(sign)
  end

  def test_rsa_encrypt
    xml_str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><jdpay><amount>1</amount><currency>CNY</currency><merchant>22294531</merchant><note></note><notifyUrl>http://10.13.81.116:63917/AsynNotifyHandler.ashx</notifyUrl><oTradeNum>1494236491939</oTradeNum><tradeNum>1494236491939_r</tradeNum><tradeTime>20170508174906</tradeTime><version>V2.0</version></jdpay>"
    sign = "UlcPzSqTH+E/zCqZFUFsY+zZ7mj7sS1XF9By2HEb9a0v6s0px6cUjTMU8J5YmJ521DkePRDiA3XXISls9XDISsZvRXJBfBe9pOLf09HzJza45x4iMuuSyxeaGEGLHo5b9bAGslcwFPNZ14yxbGcptQ4tcvO30yNDbsWroTMzGZo="
    assert_equal sign, JdPay::Sign.rsa_encrypt(xml_str)
  end

  def test_md5_sign
    order_id = "12345678"
    md5_str = "merchant=22294531&orderId=12345678&key=pvmkZFhudHnwblIxgWsnvFqDHRrVDmfU"
    assert_equal Digest::MD5.hexdigest(md5_str), JdPay::Sign.md5_sign(order_id)
  end
end
