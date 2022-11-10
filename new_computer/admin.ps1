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

#####################Disable News and interest#####################
Write-Host "Disabling news and interest..."
New-Item -Path HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows -Name "Windows Feeds" -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name EnableFeeds -Value 0 -PropertyType DWORD -Force

#####################DISABLE IPv6#####################
Write-Host "Disabling IPv6..."
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

#####################DISABLE HIBERFILE.SYS#####################
Write-Host "Disabling hibernation..."
powercfg.exe -h off

#####################NO SLEEP ON AC#####################
Write-Host "Disabling sleep on AC..."
Powercfg /Change standby-timeout-ac 0
powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

#####################7-ZIP#####################
Write-Host "Installing 7-Zip..."
ECHO Y | winget install 7zip.7zip

#####################INSTALL CHROME#####################
Write-Host "Installing Google Chrome..."
winget install Google.Chrome

#####################OPENVPN#####################
Write-Host "Installing OpenVPN..."
winget install OpenVPNTechnologies.OpenVPN

#####################ADOBE READER#####################
Write-Host "Installing Adobe Acrobat Reader..."
ECHO Y | winget install Adobe.Acrobat.Reader.64-bit

#####################INSTALL OFFICE#####################
Write-Host "Installing Office..."
$OfficeInstaller = '.\setup.exe'
$OfficeConfigure = "/configure setup.xml"
Start-Process -FilePath $OfficeInstaller -ArgumentList $OfficeConfigure -Wait

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

#Disable services
Get-Service IntelAudioService | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service Intel(R) Capability Licensing Service TCP IP Interface | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service cplspcon | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service jhi_service | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service esifsvc | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service igccservice | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service igfxCUIService2.0.0.0 | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service WMIRegistrationService | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service Intel(R) TPM Provisioning Service | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service WavesSysSvc | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service WavesAudioService | Stop-Service -PassThru | Set-Service -StartupType disabled
Get-Service RtkAudioUniversalService | Stop-Service -PassThru | Set-Service -StartupType disabled
