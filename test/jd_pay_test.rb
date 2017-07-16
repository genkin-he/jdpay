require 'test_helper'

class JdPayTest < Minitest::Test
  def test_public_key
    assert_equal TEST_RSA_PUBLIC_KEY, JdPay.public_key
  end

  def test_debug_model_default
    assert JdPay.debug_mode?
  end
end
