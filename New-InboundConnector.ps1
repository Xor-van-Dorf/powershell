#Set Hornet Security IPs inbound

New-InboundConnector -Enable $True -Name "Hornet IP Address Ranges" -SenderDomains * -RestrictDomainsToIPAddresses $true  -RequireTls  $true -SenderIPAddresses 83.246.65.0/24, 173.45.18.0/24, 94.100.128.0/24,94.100.129.0/24,94.100.130.0/24,94.100.131.0/24,94.100.132.0/24,94.100.133.0/24,94.100.134.0/24,94.100.135.0/24,94.100.136.0/24,94.100.137.0/24,94.100.138.0/24,94.100.139.0/24,94.100.140.0/24,94.100.141.0/24,94.100.142.0/24,94.100.143.0/24, 185.140.204.0/24, 185.140.205.0/24, 185.140.206.0/24, 185.140.207.0/24, 199.27.221.64/27, 216.46.11.224/27, 216.46.2.48/29, 108.163.133.224/27, 209.172.38.64/27

#Disable an inbound connector
#Set-InboundConnector "ZeroSpam to M365" -Enable $False