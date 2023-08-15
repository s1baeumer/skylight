// A member was added to a security-enabled local group
event.category='windows_event_logs' winEventLog.id = 4732
| parse ".*Account Name:$username$.*Account Domain:$domain$.*Logon ID:$logon_id$.*Group Name:$groupname$.*Group Domain:$groupdomain$.*Add.*" from winEventLog.description 
| columns event.time, endpoint.name, AccountName=trim(username), AccountDomain=trim(domain), GroupName=trim(groupname), GroupDomain=trim(groupdomain) //winEventLog.description 
| limit 10