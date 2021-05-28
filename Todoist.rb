require 'net/https'
require 'uri'
require 'json'

class Todoist
  URL = 'https://api.todoist.com/rest/v1/tasks'
  TOKEN = ENV["TODOIST_TOKEN"]
  
  def self.all_tasks_getter
    uri = URI.parse(URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    items = JSON.parse(self.response(http,uri).read_body)
    items
  end

  private

  def self.response(http,uri)
    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "Bearer #{TOKEN}"
    res = http.request(req)
    res
  end
  
end
