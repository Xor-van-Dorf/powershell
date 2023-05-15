#View services run by other than system account

Get-CIMInstance -Class Win32_Service -filter "StartName != 'LocalSystem' AND NOT StartName LIKE 'NT Authority%' " | 
    Select-Object SystemName, Name, Caption, StartMode, StartName, State | Sort-Object StartName
