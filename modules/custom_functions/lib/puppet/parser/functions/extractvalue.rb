require 'yaml'
Puppet::Parser::Functions.newfunction(:extractvalue, :type => :rvalue) do |args|
  raise Puppet::ArgumentError, "Requires 2 options" if args.length != 2
  raise Puppet::ArgumentError, "File does not exist: #{args[0]}" if ! File.exist?(args[0])
  hash = YAML.load_file(args[0])
  return "" if hash.nil?
  hash[args[1]]
end
