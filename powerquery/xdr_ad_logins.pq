// Most successful logins by username and endpoint (TOP100)
dataSource.vendor='ActiveDirectory' event.category = 'logins'
| group NumberOfSuccessfulAttempts = count(event.login.loginIsSuccessful=true) by event.login.userName, endpoint.name
| sort -NumberOfSuccessfulAttempts
| limit 100

// Most failed logins by username and endpoint (TOP100)
dataSource.vendor='ActiveDirectory' event.category = 'logins'
| group NumberOfSuccessfulAttempts = count(event.login.loginIsSuccessful=false) by event.login.userName, endpoint.name
| sort -NumberOfSuccessfulAttempts
| limit 100

// Most Logins by endpoint
dataSource.vendor='ActiveDirectory' EventID = 4624 Channel= 'Security'
| columns timestamp, Computer, EventID
| group Logins=count(EventID) by Computer
| sort -Logins  