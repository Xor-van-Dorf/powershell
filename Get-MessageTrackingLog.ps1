#For Exchange on prem

Get-MessageTrackingLog -start 3/11/2020 -Sender sender@sender.com -recipients recipient@recipient.com | Select timestamp,EventID,recipients,messagesubject