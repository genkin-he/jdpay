module JdPay
  module Des
    class << self
      def encrypt_3des(str, options = {})
        des = OpenSSL::Cipher::Cipher.new('des-ede3')
        des.encrypt
        des.key = decode_key(options)
        des.iv = des.random_iv
        str = des.update(format_str_data(str))
        to_hex(str.bytes)
      end

      def decrypt_3des(encrypt_str, options = {})
        des2 = OpenSSL::Cipher::Cipher.new('des-ede3')
        des2.decrypt
        des2.key = decode_key(options)
        des2.iv = des2.random_iv
        des2.padding = 0
        result = (des2.update(to_decimal(encrypt_str)) + des2.final).bytes
        result.first(valid_size(result.shift(4))).map(&:chr).join.force_encoding('utf-8').encode('utf-8')
      end

      private

      def decode_key(options = {})
        Base64.decode64(options[:des_key] || JdPay.des_key)
      end

      # 计算补位数据数组
      def padding_array(num)
        temp = (num + 4) % 8
        Array.new(temp == 0 ? 0 : (8 - temp), 0x00)
      end

      # 有效数据长度数组
      def valid_size_array(num)
        [num >> 24 & 0xff, num >> 16 & 0xff, num >> 8 & 0xff, num & 0xff]
      end

      # 根据数组算出有效数据值
      def valid_size(arr)
        to_hex(arr).to_i(16)
      end

      # 格式化加密元数据
      def format_str_data(str)
        str_bytes = str.bytes
        str_bytes_size = str_bytes.length
        (valid_size_array(str_bytes_size) + str_bytes + padding_array(str_bytes_size)).map(&:chr).join
      end

      # 10进制string转16进制
      def to_hex(arr)
        arr.map { |num| "%02x" % num }.join
      end

      # 16进制string转10进制
      def to_decimal(str)
        # str.scan(/../).map{ |r| r.hex.chr }.join
        Array(str).pack('H*')
      end
    end
  end
end
