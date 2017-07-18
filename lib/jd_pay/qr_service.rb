require 'rest_client'
require 'active_support/core_ext/hash/conversions'
module JdPay
  module QrService
    USABLE_METHODS = %i(qrcode_pay refund query revoke notify_verify)
    def self.method_missing(method, *args)

      super unless USABLE_METHODS.include?(method)
      qr_service_default_config = {
        mch_id: JdPay.qr_mch_id, des_key: JdPay.qr_des_key, pri_key: JdPay.qr_pri_key
      }
      args[1] = {} if args[1].nil?
      args[1] = qr_service_default_config.merge(args[1])
      JdPay::Service.public_send(method, *args)
    end
  end
end
