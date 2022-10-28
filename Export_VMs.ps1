#Exports all VMs XML in Hyper-V

$VMList = Get-VM   #Get all VMs on the host
$ExportPath = "C:\EXPORTS"   #Destination path for exported config files

foreach($VM in $VMList) {

$VMConfig = $VM.ConfigurationLocation   #Get the configuration path for the VM
$XMLFile = Get-ChildItem -Path $VMConfig *.xml -Recurse   #Get the XML file that holds the config

if (Test-Path "$($ExportPath)\$($VM.Name)") {   #Check to see if the export location exits
 
    Write-Host "Skipping creation of $($ExportPath)\$($VM.Name). Path already exists."

} else {

    New-Item -Path "$($ExportPath)\$($VM.Name)" -ItemType directory -Force   # Create the directory structure

} 

Copy-Item $XMLFile.FullName -Destination "$($ExportPath)\$($VM.Name)" -Force   #Copy the XML files to $ExportPath

}