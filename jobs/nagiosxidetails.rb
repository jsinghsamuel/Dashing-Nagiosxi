require 'open-uri'
require 'nokogiri'
 
nagios_host_status = {
  :up => 0,
  :down => 1,
  :unreachable => 2,
  :pending => 3
}
 
nagios_service_status = {
  :ok => 0,
  :warning => 1,
  :critical => 2,
  :unknown => 3,
  :pending => 4 
}

hostStatusURL = "http:///[NagiosXI_Server_URL]/backend/?cmd=gethoststatus&username=[USER_NAME]&ticket=[TICKET_STRING]&current_state="
hostServiceURL = "http://[NagiosXI_Server_URL]/nagiosxi/backend/?cmd=getservicestatus&username=[USER_NAME]&ticket=[TICKET_STRING]&current_state="

SCHEDULER.every '120', :first_in => 0 do

nagios_host_status.each do |state, code|
 	url = hostStatusURL + code.to_s
	content = Nokogiri::XML(open(url))
	recordCount = content.xpath("//recordcount")
	send_event('nagios_hosts_' + state.to_s, { current: recordCount.text } )
	end

nagios_service_status.each do |state, code|
        url = hostServiceURL + code.to_s
        content = Nokogiri::XML(open(url))
        recordCount = content.xpath("//recordcount")
        send_event('nagios_services_' + state.to_s, { current: recordCount.text } )
        end
end
