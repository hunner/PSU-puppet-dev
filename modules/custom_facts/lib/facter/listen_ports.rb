Facter.add('listen_ports') do
  setcode do
    IO.popen('netstat -lnpt').collect do |line|
      match = line.match(':(\d+)\s')
      match[1].to_i unless match.nil?
    end.compact.sort.join(',')
  end
end
