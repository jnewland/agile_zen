require 'agile_zen'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def stub_http_response_with(filename)
  format = filename.split('.').last.intern
  data = file_fixture(filename)

  response = Net::HTTPOK.new("1.1", 200, "Content for you")
  response.stub!(:body).and_return(data)

  http_request = HTTParty::Request.new(Net::HTTP::Get, 'http://localhost', :format => format)
  http_request.stub!(:perform_actual_request).and_return(response)

  HTTParty::Request.should_receive(:new).and_return(http_request)
end