require 'puppet'
require 'fileutils'
require 'mocha'
RSpec.configure do |config|
    config.mock_with :mocha
end

provider_class = Puppet::Type.type(:rcsrepo).provider(:git)
describe provider_class do
  before :each do
    @test_dir = File.join('/tmp', Time.now.to_i.to_s, 'repo')
    @resource = Puppet::Type::Rcsrepo.new({:path => @test_dir})
    @provider = provider_class.new(@resource)
  end

  it 'should ensure that a git directory does not exist' do
    @provider.exists?.should == false
  end

  it 'should create a directory for a new git init' do
    FileUtils.expects(:mkdir_p)
    FileUtils.expects(:rm_rf).never
    @provider.expects(:git).with("--git-dir", @provider.resource[:path] + '/.git', "--work-tree", @provider.resource[:path], "init")

    @provider.create
  end

  it 'should not create a directory for a git clone' do
    FileUtils.expects(:mkdir_p).never
    FileUtils.expects(:rm_rf).never #the dir doesn't exist
    @provider.expects(:git).with("clone", "git://github.com/jordansissel/puppet-examples.git", @test_dir)

    @provider.resource[:source] = 'git://github.com/jordansissel/puppet-examples.git'
    @provider.create
  end

  it 'should ensure that a git directory exists' do
    @provider.create
    @provider.exists?.should == true
  end

  it 'should ensure that destroyed repos are removed' do
    @provider.resource[:source] = 'git://github.com/jordansissel/puppet-examples.git'
    @provider.create
    @provider.exists?.should == true
    @provider.destroy
    @provider.exists?.should == false
  end

  after :each do
    FileUtils.rm_rf(@test_dir) if File.exists?(@test_dir)
  end
end
