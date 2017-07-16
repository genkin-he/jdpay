module JdPay
  module Util
    class << self
      def to_xml(params, options = {})
        options[:root] = options[:root] || 'jdpay'
        denilize(params).to_xml(options).gsub(/>[[:space:]]+/, ">")
      end

      def to_uri(params)
        params.sort.map do |k, v|
          "#{k}=#{v}"
        end.compact.join('&')
      end

      def denilize(h)
        h.each_with_object({}) { | (k, v), g |
        g[k] = (Hash === v) ? denilize(v) : v ? v : '' }
      end

      def build_pay_form(url, form_attributes)
        inputs = ''
        "<html>
          <body onload=document.getElementById('payForm').submit(); style='display: none;'>
              <form action=#{url} method='post' id='payForm'>
                #{form_attributes.each do |k, v|
                inputs << "<input type='text' name=#{k} value=#{v}>"
              end and inputs}
              </form>
            </body>
        </html>".gsub(/>[[:space:]]+/, ">")
      end
    end
  end
end
