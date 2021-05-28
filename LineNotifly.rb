require 'net/http'
require 'uri'

class LineNotifly
  TOKEN = ENV["LINE_TOKEN"]
  URI = URI.parse("https://notify-api.line.me/api/notify")

  def self.send(msg)
    request = self.mk_request(msg)
    response = Net::HTTP.start(URI.hostname, URI.port, use_ssl: URI.scheme == "https") do |https|
      https.request(request)
    end
    p response.body
  end

  private

  def self.mk_request(msg)
    request = Net::HTTP::Post.new(URI)
    request["Authorization"] = "Bearer #{TOKEN}"
    request.set_form_data(message: msg)
    request
  end

end