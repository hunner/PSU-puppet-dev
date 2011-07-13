require 'puppet'

describe Puppet::Parser::Functions.function(:join) do
  before :each do
    @scope = Puppet::Parser::Scope.new
  end

  it "should turn an array of items into a string" do
    (@scope.function_join([['foo','bar','baz'], ':'])).should == 'foo:bar:baz'
  end

  it "should fail if the correct number of arguments is not supplied" do
    expect { @scope.function_join([]) }.should \
      raise_error(Puppet::ParseError, /wrong number of arguments \(0; must be 2\)/)

    expect { @scope.function_join([['one']]) }.should \
      raise_error(Puppet::ParseError, /wrong number of arguments \(1; must be 2\)/)

    expect { @scope.function_join([['one'], 'two', 'three']) }.should \
      raise_error(Puppet::ParseError, /wrong number of arguments \(3; must be 2\)/)
  end

  it "should fail if the correct second argument is not supplied" do
    expect { @scope.function_join([['one'],['two']]).should }.should \
      raise_error(Puppet::ParseError, /wrong type of arguments/)

    expect { @scope.function_join(['one','two']).should }.should \
      raise_error(Puppet::ParseError, /wrong type of arguments/)
  end

  it "should return the correct value for an empty array" do
    @scope.function_join([[], ':']).should == ''
  end
end

