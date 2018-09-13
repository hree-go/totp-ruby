require 'openssl'
require 'base64'
require 'byebug'

MAX_OFFSET = 59

#密码更新时间
PERIOD = 60

secret = "your_secret"

digest = OpenSSL::Digest.new('sha512')

data =  ((Time.now.to_i / PERIOD).to_s 16).rjust(8, '0')

puts data

hmac = OpenSSL::HMAC.digest(digest, secret, data).unpack("C*")

offset = hmac[-1] & 0x3F;

offset = offset % MAX_OFFSET;

bin_code = ((hmac[offset] & 0x7f) << 24) | (hmac[offset+1] & 0xff) << 16 | (hmac[offset+2] & 0xff) << 8 | (hmac[offset+3] & 0xff)

puts bin_code % (10 ** 6)
