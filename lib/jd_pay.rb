require "jd_pay/version"
require "jd_pay/des"
require "jd_pay/result"
require "jd_pay/service"
require "jd_pay/sign"
require "jd_pay/util"

module JdPay
  @extra_rest_client_options = {}
  @debug_mode = true

  class << self
    attr_accessor :mch_id, :md5_key, :des_key, :pri_key, :pub_key, :extra_rest_client_options, :debug_mode

    def public_key
      self.pub_key ? self.pub_key : JdPay::Sign::JDPAY_RSA_PUBLIC_KEY
    end

    def debug_mode?
      !!@debug_mode
    end
  end
end
