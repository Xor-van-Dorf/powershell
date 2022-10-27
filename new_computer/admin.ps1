Write-host "
                                     )  
 (  (            (    *   )       ( /(  
 )\))(   ' (   ( )\ ` )  /( (     )\()) 
((_)()\ )  )\  )((_) ( )(_)))\  |((_)\  
_(())\_)()((_)((_)_ (_(_())((_) |_ ((_) 
\ \((_)/ /| __|| _ )|_   _|| __|| |/ /  
 \ \/\/ / | _| | _ \  | |  | _|   ' <   
  \_/\_/  |___||___/  |_|  |___| _|\_\  
                                        

"

#####################QUESTIONS#####################
while("y","n" -notcontains $WindowsUpdate)
{
	$WindowsUpdate = Read-Host "Voulez-vous exécuter Windows Update? y ou n"
}

while("y","n" -notcontains $rmm)
{
	$rmm = Read-Host "Voulez-vous installer le RMM? y ou n"
}

$pw = Read-Host "Quel est le mot de passe du compte support local du client?"

#####################CHANGE PASSWORD#####################
net user support $pw
net user support /expires:never

#####################INSTALL RMM#####################

if ($rmm -eq "y")
{
    .\rmm.exe
}
else
{
   write-host "Vous avez choisi de ne pas installer le RMM"
}

#####################RENAME COMPUTER#####################
$name = Read-Host "Veuillez entrer le nom de l'ordinateur"
Rename-Computer -NewName $name

#####################7-ZIP#####################

Write-Host "Installing 7-Zip..."
msiexec /i 7z2201-x64.msi /q /norestart
Start-Sleep -s 10

#####################OPENVPN#####################

Write-Host "Installing OpenVPN..."
msiexec /i OpenVPN-2.5.7-I602-amd64.msi /qn /norestart
Start-Sleep -s 10

#####################Disable News and interest#####################

Write-Host "Disabling news and interest..."
New-Item -Path HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows -Name "Windows Feeds" -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name EnableFeeds -Value 0 -PropertyType DWORD -Force

#####################DISABLE IPv6#####################

Write-Host "Disabling IPv6..."
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

#####################INSTALL CHROME#####################

Write-Host "Installing Google Chrome..."
msiexec /i googlechromestandaloneenterprise64.msi /q /norestart
Start-Sleep -s 30
#####################DISABLE HIBERFILE.SYS#####################
powercfg.exe -h off

#####################NO SLEEP ON AC#####################
Powercfg /Change standby-timeout-ac 0

#####################INSTALL OFFICE#####################

Write-Host "Installing Office..."
$OfficeInstaller = '.\setup.exe'
$OfficeConfigure = "/configure setup.xml"
Start-Process -FilePath $OfficeInstaller -ArgumentList $OfficeConfigure -Wait

#####################START ADOBE READER INSTALLER#####################

Write-Host "Installing Adobe Acrobat Reader..."
Write-Host 'Downloading Files...'
wget "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/2200220191/AcroRdrDC2200220191_fr_FR.exe" -OutFile "AcroRdrDC2200220191_fr_FR.exe"

Write-Host 'Extracting Files...'
Start-Process -FilePath .\AcroRdrDC2200220191_fr_FR.exe -ArgumentList '-sfx_o"C:\AdobeReaderExtracted" -sfx_ne.\AcroRdrDC2200220191_fr_FR.exe -sfx_o"C:\AdobeReaderExtracted" -sfx_ne' -Wait

Write-Host 'Creating Admin install...'
Start-Process -FilePath msiexec -ArgumentList '/a c:\AdobeReaderExtracted\AcroRead.msi TARGETDIR="c:\AcrobatReaderDC_AIP" /quiet' -Wait

Write-Host 'Patching Admin install...'
Start-Process -FilePath msiexec -ArgumentList '/a C:\AcrobatReaderDC_AIP\AcroRead.msi /p C:\AdobeReaderExtracted\AcroRdrDCUpd2200220191.msp /quiet' -Wait

Write-Host 'Creating setup.ini'
New-Item C:\AcrobatReaderDC_AIP\setup.ini
Set-Content C:\AcrobatReaderDC_AIP\setup.ini @"
[Startup]
RequireMSI=3.0
CmdLine=/sall /rs

[Product]
msi=AcroRead.msi
"@

Write-Host 'Installing...'


Write-Host 'Rename folder, cleanup and installing'
Rename-Item C:\AcrobatReaderDC_AIP C:\AcrobatReaderDC_2022.002.20191
Move-Item C:\AcrobatReaderDC_2022.002.20191 .\AcrobatReaderDC_2022.002.20191
msiexec /i "c:\script\AcrobatReaderDC_2022.002.20191\AcroRead.msi" /q /norestart
Remove-Item C:\AdobeReaderExtracted -Force -Recurse
Remove-Item .\AcroRdrDC2200220191_fr_FR.exe -Force -Recurse

#####################WINDOWS UPDATE#####################

if ($WindowsUpdate -eq "y")
{
	ECHO O | powershell Install-Module PowerShellGet -Force
    ECHO O | powershell Install-Module PSWindowsUpdate
	Get-WindowsUpdate
	ECHO Y | powershell Install-WindowsUpdate –AcceptAll
}
else
{
   write-host "Vous avez choisi de ne pas installer Windows Update"
}
