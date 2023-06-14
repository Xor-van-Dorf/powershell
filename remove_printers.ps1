#Get all installed printers
$printers = Get-WmiObject -Class Win32_Printer | Select-Object Name

#Loop through each printer
foreach ($printer in $printers) {
    $printerName = $printer.Name

    #Check if the printer name contains "NPI" and does not contain "CTDU"
    if ($printerName -like "*NPI*" -or $printerName -like "*Brother*" -and $printerName -notlike "*CTDU*") {
        # Uninstall the printer
        Write-Host "Uninstalling printer: $printerName"
        $printer | Remove-Printer
    }
}
Write-Host "Printer uninstallation completed."
