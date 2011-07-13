require 'puppet'
require 'pp'
Puppet::Reports.register_report(:myreport) do
  desc "document the report"
  def process
    File.open('/var/log/reports/report.log', 'a') do |f|
      resource_statuses.each do |k,v|
        v.events.each do |e|
          f.puts "Resource => #{k}, property => #{e.property}, desired_value => #{e.desired_value}, previous_value => #{e.previous_value}, message => #{e.message}, status => #{e.status}"
        end
      end
    end
  end
end
