#For Office 2013/2016, it's forcing modern auth

New-ItemProperty -Path "HKLM:\HKEY_CURRENT_USER\Software\Microsoft\Exchange\" -Name AlwaysUseMSOAuthForAutoDiscover -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity\" -Name EnableADAL -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity\" -Name Version -Value 1 -PropertyType DWORD -Force