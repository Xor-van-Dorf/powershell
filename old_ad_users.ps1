$Users = Get-ADUser -Filter * -Properties LastLogonDate | where {$_.LastLogonDate -lt (Get-Date).AddDays(-180)}
#$TargetOU = 'OU=DisabledUsers,OU=Accounts,DC=your,DC=domain,DC=com' # Example

Foreach ($User in $Users)
{
Disable-ADAccount $User
#Move-ADObject -Identity $User -TargetPath $TargetOU
}