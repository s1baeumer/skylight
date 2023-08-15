// Count outbound connections by geo location country
event.type = 'IP Connect' event.network.direction = 'OUTGOING' !net_private(dst.ip.address) 
| group NumberOfConnections=count(geo_ip_country(dst.ip.address)) by Country=geo_ip_country(dst.ip.address)
| sort -NumberOfConnections

// Count inbound connections by geo location country
event.type = 'IP Connect' event.network.direction = 'INCOMING' !net_private(src.ip.address) 
| group NumberOfConnections=count(geo_ip_country(src.ip.address)) by Country=geo_ip_country(src.ip.address)
| sort -NumberOfConnections