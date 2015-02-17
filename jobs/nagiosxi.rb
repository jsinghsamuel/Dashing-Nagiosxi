
SCHEDULER.every '60' do

require 'open-uri'
require 'nokogiri'

nagios_host_status = {
  :down => 1,
  :unreachable => 2,
}

nagios_service_status = {
  :warning => 1,
  :critical => 2,
}


hostStatusURL = "http:///[NagiosXI_Server_URL]/backend/?cmd=gethoststatus&username=[USER_NAME]&ticket=[TICKET_STRING]&current_state="
hostServiceURL = "http://[NagiosXI_Server_URL]/nagiosxi/backend/?cmd=getservicestatus&username=[USER_NAME]&ticket=[TICKET_STRING]&current_state="

    service_critical_count = 0
    service_warning_count = 0
    host_down_count = 0
    host_unreachable_count = 0

nagios_host_status.each do |state, code|
 	url = hostStatusURL + code.to_s
	content = Nokogiri::XML(open(url))
	recordCount = content.xpath("//recordcount")
	
	if (code == 1)
		host_down_count = recordCount.text
	elsif (code == 2)
		host_unreachable_count = recordCount.text
	end
end

nagios_service_status.each do |state, code|
        url = hostServiceURL + code.to_s
        content = Nokogiri::XML(open(url))
        recordCount = content.xpath("//recordcount")

	if (code == 1)
		service_critical_count = recordCount.text
	elsif (code == 2)
		service_warning_count = recordCount.text
	end

end

    status = host_down_count.to_i > 0 ? "red" : (host_unreachable_count.to_i > 0 ? "yellow" : "green")
    status = service_critical_count.to_i > 0 ? "red" : (service_warning_count.to_i > 0 ? "yellow" : "green")

    if service_critical_count.to_i == 0 and service_warning_count.to_i == 0 and host_down_count.to_i == 0 and host_unreachable_count.to_i == 0
      if content.length == 0
        status = "error"
      end
    end

    send_event('nagiosxi', { service_criticals: service_critical_count, service_warnings: service_warning_count, host_down: host_down_count, host_unreachable: host_unreachable_count, status: status })

end
