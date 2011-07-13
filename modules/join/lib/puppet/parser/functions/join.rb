Puppet::Parser::Functions.newfunction(:join, :type => :rvalue) do |args|
  raise Puppet::ParseError, "join(): wrong number of arguments (#{args.length}; must be 2)" if args.length != 2
  raise Puppet::ParseError, "join(): wrong type of arguments (must be Array or String)" if ! args[0].kind_of?(Array) or ! args[1].kind_of?(String)
  #args = args.flatten
  join = args.pop
  args.join(join)
end
