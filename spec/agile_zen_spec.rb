require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "AgileZen" do
  it "should provide a version constant" do
    AgileZen::VERSION.should be_instance_of(String)
  end
end
