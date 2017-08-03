module JdPay
  module Util
    XML_HEAD = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    class << self
      def to_xml(params, options = {})
        options[:root] = options[:root] || 'jdpay'
        XML_HEAD + xml_out({ options[:root] => denilize(params) })
      end

      def xml_out(params)
        xml = []
        params.each do |k, v|
          if v.is_a?(Array)
            v.each do |ary|
              xml << "<#{k}>#{xml_out(ary)}</#{k}>"
            end
          elsif v.is_a?(Hash)
            xml << "<#{k}>#{xml_out(v)}</#{k}>"
          else
            xml << "<#{k}>#{v}</#{k}>"
          end
        end
        xml.join
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
