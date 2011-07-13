require 'puppet'
describe Puppet::Parser::Functions.function(:join) do
  it "should turn an array of items into a string" do
    scope = Puppet::Parser::Scope.new
    scope.function_join(['foo','bar','baz'], ':').should == 'foo:bar:baz'
  end
  it "should fail if the correct arguments are not supplied"
end

