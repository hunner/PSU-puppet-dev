require 'puppet'
require 'fileutils'
provider_class = Puppet::Type.type(:rcsrepo).provider(:git)
describe provider_class do
  before :each do
    @test_dir = File.join('/tmp', Time.now.to_i.to_s, 'repo')
    @resource = Puppet::Type::Rcsrepo.new({:path => @test_dir})
    @provider = provider_class.new(@resource)
  end

  it 'should ensure that a git directory exists' do
    @provider

  after :each do
    FileUtils.rm_rf(@test_dir)
  end
end
