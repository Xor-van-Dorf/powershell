#Used to set bulk AD passwords

#CSV file must be:
#samAccountName|Password



Import-Module ActiveDirectory
# Set the new password
$newPassword = ConvertTo-SecureString -AsPlainText "MyP@ssw0rd" -Force
# Import users from CSV
Import-Csv ".\ADUsers.csv" | ForEach-Object {
$samAccountName = $_."samAccountName"
 
#Un-comment the below line if your CSV file includes password for all users
$newPassword = ConvertTo-SecureString -AsPlainText $_."Password"  -Force
 
# Reset user password.
Set-ADAccountPassword -Identity $samAccountName -NewPassword $newPassword -Reset

Write-Host " AD Password has been reset for: "$samAccountName
}
