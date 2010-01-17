require 'agile_zen'
require 'spec'
require 'spec/autorun'
require 'active_resource/http_mock'

def fixture(filename)
  open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}")).read
end