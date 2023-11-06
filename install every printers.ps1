#Install every printers from print server. Change CALDC02 as needed

$printers = Get-Printer -Computername CALDC02
$server = "\\caldc02\"
ForEach ($printer in $printers) {
  $printermap = $server + $printer.name
  Invoke-Expression 'rundll32 printui.dll PrintUIEntry /ga /in /q /n $($printermap)'
  start-sleep -seconds 2 #wait 2 seconds
}