#SMTP infos
$smtpServer = "mail.smtp2go.com"
$smtpPort = 2525
$smtpUsername = "SMTPUSERNAME"
$smtpPassword = ConvertTo-SecureString -String "PASSWORD" -AsPlainText -Force
$smtpCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, $smtpPassword

#Get thetime of day
$min = Get-Date "06:00"
$max = Get-Date "17:00"
$now = Get-Date

#Get the day
[DateTime]$today = get-date
$today2=$today.DayOfWeek -notmatch "Sunday|Saturday"

$recipients = @("RECIPIENT1 <RECIPIENT1>", "RECIPIENT2 <RECIPIENT2>")

if ($min.TimeOfDay -le $now.TimeOfDay -and $max.TimeOfDay -ge $now.TimeOfDay) {
  If ($today2 -eq $True) {
    Send-MailMessage -To $recipients -From "FROM" -Subject "Serveur en ligne" -Body "Le serveur est en ligne." -SmtpServer $smtpServer -Port $smtpPort -UseSSL -Credential $smtpCredential 
   }
}