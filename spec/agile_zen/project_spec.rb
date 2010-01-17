require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'projects' do

  it "should be accessible easily" do
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/api/v1/projects", AgileZen::Base.headers, fixture('projects.xml')
    end
    projects = AgileZen::Project.all
    projects.should be_instance_of(Array)
    projects.length.should == 2
    projects.first.should be_instance_of(AgileZen::Project)
    projects.first.name.should == 'World Peace'
  end

  it "should work if there's only one in the collection" do
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/api/v1/projects", AgileZen::Base.headers, fixture('projects_with_only_one.xml')
    end
    projects = AgileZen::Project.all
    projects.should be_instance_of(Array)
    projects.length.should == 1
    projects.first.should be_instance_of(AgileZen::Project)
    projects.first.name.should == 'World Peace'
  end
end