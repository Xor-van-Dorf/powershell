#For syncing manually the time

net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"0.ca.pool.ntp.org 1.ca.pool.ntp.org 2.ca.pool.ntp.org 3.ca.pool.ntp.org"
net start w32time
w32tm /config /update
w32tm /resync /rediscover
