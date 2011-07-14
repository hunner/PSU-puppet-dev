require 'puppet'
require 'puppet/type/rcsrepo'
describe Puppet::Type.type(:rcsrepo) do
  before :each do
    @rcsrepo = Puppet::Type.type(:rcsrepo).new()
  end

  it 'should use git provider as needed' do
    @rcsrepo[:source] = 'git://foo'
    @rcsrepo[:provider].should == 'git'
  end
end
