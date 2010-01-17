require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "AgileZen" do
  it "should provide a version constant" do
    AgileZen::VERSION.should be_instance_of(String)
  end

  it "should accept an API key" do
    AgileZen::Base.key = 'key'
    AgileZen::Base.headers['X-Zen-ApiKey'].should == 'key'
  end

  it "should be configured to not send an extension" do
    AgileZen::Base.format.extension.should == ''
  end

  it "should default to non-ssl" do
    AgileZen::Base.site.to_s.should == 'http://agilezen.com/api/v1/'
  end

  it "should allow ssl access" do
    AgileZen::Base.ssl = true
    AgileZen::Base.site.to_s.should == 'https://agilezen.com/api/v1/'
  end
end
