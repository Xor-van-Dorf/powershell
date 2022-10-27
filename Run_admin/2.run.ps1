# Set up path and user variables #
$AESKeyFilePath = "c:\AESkey\aeskey.txt" # location of the AESKey #
$SecurePwdFilePath = "c:\AESkey\credpassword.txt" # Location of the file that hosts the encrypted password #               
$userUPN = "garagemorin\support" # User account login #
 
# Use key and password to create local secure password #
$AESKey = Get-Content -Path $AESKeyFilePath
$pwdTxt = Get-Content -Path $SecurePwdFilePath
$securePass = $pwdTxt | ConvertTo-SecureString -Key $AESKey
 
# Create a new psCredential object with required username and password #
$adminCreds = New-Object System.Management.Automation.PSCredential($userUPN, $securePass)
 
 
# Use the $adminCreds to run elevated exe #
Start-Process powershell.exe  -Credential $adminCreds -ArgumentList "-command start-process 'C:\Program Files (x86)\iVMS-4200 Site\iVMS-4200 Client\Client\iVMS-4200.Framework.C.exe' -Verb runAs"