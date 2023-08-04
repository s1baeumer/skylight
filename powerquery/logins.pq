// Most successful logins by username and endpoint (TOP100)
event.category = 'logins'
| group NumberOfSuccessfulAttempts = count(event.login.loginIsSuccessful=true) by event.login.userName, endpoint.name
| sort -NumberOfSuccessfulAttempts
| limit 100
 // Most failed logins by username and endpoint (TOP100)
event.category = 'logins'
| group NumberOfSuccessfulAttempts = count(event.login.loginIsSuccessful=false) by event.login.userName, endpoint.name
| sort -NumberOfSuccessfulAttempts
| limit 100
 