// A member was added to a security-enabled local group
event.category='windows_event_logs' winEventLog.id = 4732
| parse ".*Account Name:$username$.*Account Domain:$domain$.*Logon ID:$logon_id$.*Group Name:$groupname$.*Group Domain:$groupdomain$.*Add.*" from winEventLog.description 
| columns event.time, endpoint.name, AccountName=trim(username), AccountDomain=trim(domain), GroupName=trim(groupname), GroupDomain=trim(groupdomain) //winEventLog.description 
| limit 10


// Potential brute-force 
event.category = 'logins' event.login.loginIsSuccessful=false
| group 
NumberOfFailedAttemptsTotal=count(), 
NumberOfUserNames=estimate_distinct(event.login.userName where event.login.loginIsSuccessful=false ),
NumberOfFailedAttemptsSystem=count(event.login.type where event.login.type='SYSTEM' ) , 
NumberOfFailedAttemptsService=count(event.login.type where event.login.type='SERVICE' ) , 
NumberOfFailedAttemptsNetwork=count(event.login.type where event.login.type='NETWORK' ) ,
NumberOfFailedAttemptsNetworkClearText=count(event.login.type where event.login.type='NETWORK_CLEAR_TEXT' ) ,
NumberOfFailedAttemptsNetworkCredentials=count(event.login.type where event.login.type='NETWORK_CREDENTIALS' ) ,
NumberOfFailedAttemptsRemoteInteractive=count(event.login.type where event.login.type='REMOTE_INTERACTIVE' ) ,
NumberOfFailedAttemptsInteractive=count(event.login.type where event.login.type='INTERACTIVE' ) 
by endpoint.name
| filter NumberOfUserNames > 3
| sort -NumberOfFailedAttemptsTotal