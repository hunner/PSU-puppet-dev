require 'puppet'
Puppet::Reports.register_report(:customreport) do
  desc "document the report"
  def process
    File.open('/var/log/puppet_failures.log', 'a') do |f| 
      logs.each do |l| 
        if l.level == :err
          f.puts "Error: #{l.message}"
        end 
      end 
    end
  end
end

