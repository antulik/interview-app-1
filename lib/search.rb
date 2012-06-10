require 'net/https'
require 'json'

class Search

  class << self
    attr_accessor :base_url, :key, :country

    def configure
      yield self
    end
  end

  def self.find query, params = {}
    opt = {
        :alt     => 'json',
        :country => country,
        :key     => key,
        :q       => query
    }.merge! params
    url = url_with_params(base_url, opt)
    uri = URI.parse(url)

    http             = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request          = Net::HTTP::Get.new(uri.request_uri)

    resp = http.request(request)
    data = resp.body

    JSON.parse(data)
  end

  private

  def self.url_with_params base_url, params = {}
    "#{base_url}?".concat(params.collect { |k, v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
  end

end
